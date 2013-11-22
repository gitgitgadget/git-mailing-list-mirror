From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 11:15:59 -0500
Message-ID: <20131122161558.GA4170@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121160426.GA21843@kitenet.net>
 <CAP8UFD2S1HUDYLbmEGFqLcBFExuB0h7=gqwsQ0qjpMSc+YaXog@mail.gmail.com>
 <20131122095801.GB12042@sigill.intra.peff.net>
 <CAP8UFD1fMTrJGo9Z4+jdWqc-=UmPG1jQjwTij4962WDoh_a1DA@mail.gmail.com>
 <20131122112429.GA16172@sigill.intra.peff.net>
 <CAP8UFD1z4NsmgzrnPmqHo7CkNRkgg24qT2SGnFjhjrzckdKoTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 17:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjtOo-0006Mn-7E
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 17:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab3KVQQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 11:16:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:43846 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752565Ab3KVQQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 11:16:00 -0500
Received: (qmail 29870 invoked by uid 102); 22 Nov 2013 16:16:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Nov 2013 10:16:00 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Nov 2013 11:15:59 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD1z4NsmgzrnPmqHo7CkNRkgg24qT2SGnFjhjrzckdKoTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238193>

On Fri, Nov 22, 2013 at 03:23:31PM +0100, Christian Couder wrote:

> > The only site which calls read_sha1_file_extended directly and does not
> > pass the REPLACE flag is in streaming.c. And that looks to be a case of
> > (2), since we resolve the replacement at the start in open_istream().
> 
> Yeah, you are right. Sorry for overlooking this.
> 
> But anyway it looks redundant to me to have both this REPLACE flag and
> the read_replace_refs global variable, so I think a proper solution
> would involve some significant refactoring.

I don't think it is redundant. The global variable is about "does the
whole operation want the replace feature turned on" and the flag is
about "does this particular callsite want the replace featured turned
on". We use the feature iff both are true.

We could implement the callsite flag by tweaking the global right before
the call to read_sha1_file, but then we would have to remember to turn
it back on afterwards. If this were a language with dynamic scopes like
Perl, that would be easy. But in C you have to remember to reset it in
all code paths. :)

In some cases it does make sense to turn the feature off for a whole
command (like pack-objects); using the global makes sense there. And
indeed, we seem to do it already in things like fsck, index-pack, etc.
So that answers my question of why I did not see more of case (1) in my
previous email: they do not need per-callsite disabling, because they do
it for the whole command.

> And if we decide to keep a REPLACE flag we might need to add one to
> sha1_object_info_extended() too.

Yes, but somebody needs to look at all of the callsites and decide which
form they want. :)

I did a brief skim, and the ones I noticed were:

  - several spots in index-pack, pack-objects, etc. But these are
    already covered by unsetting read_replace_refs.

  - replace_object looks at both the original and new object to compare
    their types (due to your recent patches); it would obviously want to
    get the true type of the original object

  - When creating tags and trees, we care about the type of the object
    (the former for the "type" line of the tag, the latter to set the
    mode). What should they do with replace objects? As above, it is
    probably insane to switch types, so it may not matter for practical
    purposes.

  - istream_source in streaming.c would probably want to turn it off for
    the same reason it uses read_sha1_file_extended

So I think most sites would be unaffected, but due to the second and
fourth item in my list above, we would need a flag for
sha1_object_info_extended.

-Peff
