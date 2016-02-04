From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] submodule-config: keep update strategy around
Date: Wed, 3 Feb 2016 22:15:27 -0500
Message-ID: <20160204031527.GB21105@sigill.intra.peff.net>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
 <1454435497-26429-2-git-send-email-sbeller@google.com>
 <xmqqy4b1l7cd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 04:15:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRAOM-0006tL-Oo
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 04:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbcBDDPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 22:15:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:37109 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757354AbcBDDPa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 22:15:30 -0500
Received: (qmail 987 invoked by uid 102); 4 Feb 2016 03:15:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 22:15:30 -0500
Received: (qmail 30420 invoked by uid 107); 4 Feb 2016 03:15:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 22:15:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2016 22:15:27 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy4b1l7cd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285394>

On Wed, Feb 03, 2016 at 03:09:06PM -0800, Junio C Hamano wrote:

> > +	} else if (!strcmp(item.buf, "update")) {
> > +		if (!value)
> > +			ret = config_error_nonbool(var);
> > +		else if (!me->overwrite && submodule->update != NULL)
> > +			warn_multiple_config(me->commit_sha1, submodule->name,
> > +					     "update");
> > +		else {
> > +			free((void *) submodule->update);
> > +			submodule->update = xstrdup(value);
> 
> This is a tangent, but whenever I see us needing to cast the
> constness away to call free(), it makes me wonder how much value we
> are getting by marking the field as a pointer to "const" in the
> first place.  With this patch alone, we cannot really see it,
> because we cannot see how it is used.

I suspect we may have just inherited this from other config code. We
typically use a const pointer to declare config strings, because
git_config_string() takes a pointer to a const pointer for its
destination. And we do that because some strings need BSS defaults, and
we cannot assign a string literal to a non-const pointer without a cast
(and if we did, it is inviting somebody to accidentally free() the
string literal).

So _somebody_ generally has to cast to cover all situations. But here we
are not using git_config_string() at all, so I think we could get away
with a non-const pointer.

As a tangent to your tangent, another problem with git_config_string()
and const pointers is that we never free the "old" value for a string,
and we leak it.  It's usually OK in practice because people do not have
unbounded repetition of their config keys. We don't free because it
would be an error to do so for a default-assigned string literal. But
for any string variable which defaults to NULL, it would be fine.

IOW, git_config_string (and probably git_config_pathname) could be
implemented like this:

  int git_config_string(char **dest, const char *var, const char *value)
  {
	if (!value)
		return config_error_nonbool(var);
	free(*dest);
	*dest = xstrdup(value);
	return 0;
  }

and then:

  char *git_foo;
  ...
      return git_config_string(&git_foo, var, value);

would do the right thing. But I'm not sure how much that would ripple
through the code-base. Any string who wants:

  const char *git_foo = "default";

would have to use another function (and keep the leak), or convert its
uses to treat NULL the same as "default". I have a suspicion that _most_
sites would prefer it the non-const way, and it would be a net win. But
I think you'd have to replace the function, then convert all of the
variables used (which the compiler will helpfully point out to you
because of the type mismatch), and then see how many are broken (which
the compiler will also tell you).

-Peff
