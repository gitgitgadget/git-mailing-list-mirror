From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC PATCH 0/4] git_connect: add some flexibility
Date: Fri, 29 Apr 2016 08:29:36 +0900
Message-ID: <20160428232936.GA8663@glandium.org>
References: <1461852759-28429-1-git-send-email-mh@glandium.org>
 <xmqqbn4t637r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 01:29:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avvNW-0004H6-15
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 01:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbcD1X3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 19:29:46 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38710 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbcD1X3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 19:29:45 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1avvNI-0002NT-4X; Fri, 29 Apr 2016 08:29:36 +0900
Content-Disposition: inline
In-Reply-To: <xmqqbn4t637r.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292960>

On Thu, Apr 28, 2016 at 10:41:12AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > As you may be aware, I'm working on a git remote helper to access
> > mercurial repositories (https://github.com/glandium/git-cinnabar/).
> >
> > At the moment, a small part is written in C, relying on the git code
> > base, but eventually, there would be more C.
> >
> > As I want to get rid of the dependency on Mercurial itself, I'm planning
> > to implement the wire protocol parts in git-cinnabar.
> 
> While all of the above sounds like a good thing to do, what I do not
> understand is why you need to even touch git_connect() at all, and
> we certainly do *not* want you to touch it to make its external
> interface unnecessarily ugly and complex with features that are only
> necessary if it needs to talk to non-git services.
> 
> In other words, why can't this cinnabar thing live on the other side
> of transport API, just like Git transport itself does not know about
> cURL and HTTP when talking with https:// repositories?

It does live on the other side of transport API. The changes are not
about git itself talking to mercurial servers. They are about a remote
helper (git-cinnabar), using native code based on git core code, to talk
to mercurial servers. Because I'd rather bend git_connect a little, if I
can, than copy it (as well as parse_connect_url). Because I want to
benefit from all tweaks it has (handling GIT_SSH/GIT_SSH_COMMAND
properly, handling tortoiseplink/plink properly, handling IPv6 forms of
the ssh url properly, ...)

Now, tweaking git_connect is one possible way to do what I want. Another
would be to make parse_connect_url non-static, and move the ssh command
line construction to a separate (non-static) function. Something with a
signature like:
  void prepare_ssh_command(struct argv_array **command,
                           const char *hostandport)

that would essentially do the part of git_connect that is in the if
(protocol == PROTO_SSH) block (not sure how CONNECT_DIAG_URL would fit
in this, though).

Thoughts?

Mike
