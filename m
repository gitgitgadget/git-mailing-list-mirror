From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH] Allow hideRefs to match refs outside the namespace
Date: Sun, 01 Nov 2015 12:27:16 +0100
Message-ID: <20151101112716.3758.7843@typhoon.lan>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
 <1446046920-15646-1-git-send-email-lfleischer@lfos.de>
 <xmqq1tcfm09k.fsf@gitster.mtv.corp.google.com>
 <20151031084917.26006.98611@typhoon.lan>
 <xmqqsi4rhrmc.fsf@gitster.mtv.corp.google.com>
 <20151031234039.3799.78352@typhoon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 12:27:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsqnF-00023q-A9
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 12:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbbKAL1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 06:27:20 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:47287 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbbKAL1T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2015 06:27:19 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 28a7e9b7;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Sun, 1 Nov 2015 12:27:17 +0100 (CET)
In-Reply-To: <20151031234039.3799.78352@typhoon.lan>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280616>

On Sun, 01 Nov 2015 at 00:40:39, Lukas Fleischer wrote:
> On Sat, 31 Oct 2015 at 18:31:23, Junio C Hamano wrote:
> > [...]
> > You earlier (re)discovered a good approach to introduce a new
> > feature without breaking settings of existing users when we
> > discussed a "whitelist".  Since setting the configuration to an
> > empty string did not do anything in the old code, an empty string
> > was an invalid and non-working setting.  By taking advantage of that
> > fact, you safely can say "if you start with an empty that would
> > match everything, we'll treat all the others differently from the
> > way we did before" if you wanted to.  I think you can follow the
> > same principle here.  For example, I can imagine that the rule for
> > the "ref-is-hidden" can be updated to:
> > 
> >  * it now takes refname and also the fullname before stripping the
> >    namespace;
> > 
> >  * hide patterns that is prefixed with '!' means negative, just as
> >    before;
> > 
> >  * (after possibly '!' is stripped), hide patterns that is prefixed
> >    with '^', which was invalid before, means check the fullname with
> >    namespace prefix, which is a new rule;
> > 
> >  * otherwise, check the refname after stripping the namespace.
> > 
> > Such an update would allow a new feature "we now allow you to write
> > a pattern that determines the match before stripping the namespace
> > prefix" without breaking the existing repositories, no?
> > 
> 
> Yes. If I understood you correctly, this is exactly what I suggested in
> the last paragraph of my previous email (the only difference being that
> I suggested to use "/" as full name indicator instead of "^" but that is
> just an implementation detail). I will look into implementing this if
> that is the way we want to go.
> [...]

There are two more things I noticed.

Firstly, while looking for other callers of ref_is_hidden(), I realized
that send_ref() in upload-pack.c contains these lines of code:

    const char *refname_nons = strip_namespace(refname);                    
    struct object_id peeled;                                                
                                                                            
    if (mark_our_ref(refname, oid))                                         
            return 0;                                                       

where mark_our_ref() performs the ref_is_hidden() check on its first
parameter. So, in contrast to receive-pack, we already match the
original full reference (and not the stripped one) against the hideRefs
pattern there. In particular, when using transfer.hideRefs, the same
pattern does different things when receiving and uploading.

Now, this cannot be intended behavior and I do not think this is
something we want to retain when improving that feature. My suggestion
is:

1. Define the (current) semantics of hideRefs pattern. It either needs
   to be defined to match full references or stripped references. Both
   definitions are equivalent when Git namespaces are not used.
   
   It probably makes sense to define hideRefs patterns to match stripped
   references. If anybody relied on the upload-pack behavior of patterns
   matching full references, it may happen that more refs are hidden
   when that behavior is adjusted to match the new hideRefs semantics.
   The administrator would become aware of that change soon if it
   affects anything (i.e. hides things that should not be hidden). But I
   am pretty sure that this behavior isn't currently being relied on
   either way. Both Git namespaces and hideRefs aren't very popular
   features and anybody using that combination would probably have
   noticed the inconsistency and reported a bug earlier.

2. Improve the documentation and describe the hideRefs semantics better.
   Include details on the choice we made in (1).

3. Fix the send_ref() code in either receive-pack or upload-pack,
   depending on which is buggy according to our new definition.

4. Improve hideRefs patterns and allow to match both full references and
   stripped references by using a special indicator as suggested
   earlier.

5. Add a note on the change in behavior to the release notes of the
   release that "breaks backwards compatibility". Putting it in quotes
   because I actually think that we are fixing a bug rather than
   breaking compatibility. But since there was no documentation on the
   correct behavior, the former implementation was, technically, the
   only specification of "correct" behavior that existed at that
   point...

The second thing I noticed is that having syntax for allowing matches
against both full references and stripped references is extremely handy
and desirable, even if we would not have to introduce it for backwards
compatibility. For example, using the syntax Junio described earlier, my
initial use case could be solved by

    receive.hideRefs=^refs/
    receive.hideRefs=!refs/

which means "Hide all references but do not hide references from the
current namespace." Here, I am assuming that patterns for stripped refs
never match anything outside the current namespace because those
patterns become NULL after stripping. This kind of supersedes the other
discussion on setting configuration via environment as well (at least in
this context).

Regards,
Lukas
