From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [RFC] GPG-Signed pushes & commits: differentiating between no
 signature and an unknown key
Date: Tue, 2 Feb 2016 00:43:30 +0000
Message-ID: <robbat2-20160202T002257-169038640Z@orbis-terrarum.net>
References: <robbat2-20160201T220940-187080200Z@orbis-terrarum.net>
 <xmqqmvrkt5ay.fsf@gitster.mtv.corp.google.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 01:44:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQP4m-00076C-32
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 01:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbcBBAnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 19:43:37 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:54419 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbcBBAng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 19:43:36 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 1AA8D340C5E
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 00:43:31 +0000 (UTC)
Received: (qmail 23958 invoked by uid 10000); 2 Feb 2016 00:43:30 -0000
Content-Disposition: inline
In-Reply-To: <xmqqmvrkt5ay.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285229>

On Mon, Feb 01, 2016 at 02:49:09PM -0800,  Junio C Hamano wrote:
> Are you talking about something other than prepare_push_cert_sha1()?
I went and verified it, and what was reported to me was slightly wrong. Only
some of the field are empty, notably CERT_KEY and SIGNER.

Signed push with an unknown key:
===
remote: No signature found
remote: Your push was not signed with a known key.
remote: You MUST use git push --signed with a known key.
remote: If you just updated your key, please wait 15 minutes for sync.
remote: git-receive-pack variables:
remote: GIT_PUSH_CERT='1c471177906014e65e2825ee71572bf749970c16'
remote: GIT_PUSH_CERT_KEY=''
remote: GIT_PUSH_CERT_NONCE='1454372558-35db7be4533958f14731'
remote: GIT_PUSH_CERT_NONCE_SLOP=''
remote: GIT_PUSH_CERT_NONCE_STATUS='OK'
remote: GIT_PUSH_CERT_SIGNER=''
remote: GIT_PUSH_CERT_STATUS='N'
To git+ssh://git@git.gentoo.org/repo/gentoo
 ! [remote rejected] master -> master (pre-receive hook declined)
===

Unsigned push:
===
remote: Unknown GIT_PUSH_CERT_STATUS
remote: Your push was not signed with a known key.
remote: You MUST use git push --signed with a known key.
remote: If you just updated your key, please wait 15 minutes for sync.
remote: git-receive-pack variables:
remote: GIT_PUSH_CERT=''
remote: GIT_PUSH_CERT_KEY=''
remote: GIT_PUSH_CERT_NONCE=''
remote: GIT_PUSH_CERT_NONCE_SLOP=''
remote: GIT_PUSH_CERT_NONCE_STATUS=''
remote: GIT_PUSH_CERT_SIGNER=''
remote: GIT_PUSH_CERT_STATUS=''
To git+ssh://git@git.gentoo.org/repo/gentoo
 ! [remote rejected] master -> master (pre-receive hook declined)
===

Here's the raw blob, while it still exists.
====
certificate version 0.1
pusher 0x55272E9740B89B54 1454372558 -0800
pushee git+ssh://git.gentoo.org/repo/gentoo
nonce 1454372558-35db7be4533958f14731

99a4d87ed7b79ea050adb99f941accf33e4ba963 71535a9475cdd4949c4031676238dc9f60e1828a refs/heads/master
-----BEGIN PGP SIGNATURE-----
...
-----END PGP SIGNATURE-----
====


> > In the case of the signed push with the unknown key, they should remain
> > set.
> 
> In any case, I think "should" is relative to the balance between
> convenience and safety.  If you set up your receiving end to use a
> keyring that holds trusted keys and nothing else, it makes it harder
> to make mistakes in the script and accept something you shouldn't if
> the validation script is fed "No, this is not good" if a push is
> signed by unknown key, so showing "known to be bad" and "unsure if
> it is good" the same way with 'N' is what "should" happen from that
> point of view.
Ok, at the very least, can we consider populating GIT_PUSH_CERT_KEY and
GIT_PUSH_CERT_SIGNER even with GIT_PUSH_CERT_STATUS set to N?

Then change the documentation to say 'No valid signature' rather than 'No
signature'? (introducing another letter would be better I think).

> 
> Of course, a set-up that fetches unknown keys lazily when they are
> first encountered would need more work to do the verification
> themselves, but as long as GIT_PUSH_CERT itself is exported that
> should be possible (iow, we are trying to make simple way less error
> prone, while allowing more advanced use possible, if harder).
If it fetches the new key, and finds it be in some WOT or external trustdb, it
could accept it.

> If the blob object name is not exported depending on the validation
> status, that certainly sounds like a bug, as that would make "more
> advanced use" above impossible.  But I am not sure how that happens.
I think the earlier blobs got GC'd, hence why I didn't find them.

Advanced usage: Maybe record them to a ref of failed pushes (would be in the
hook to check the signature).

I think after this is cleaned up, I'll send the Gentoo require-signed-push hook
for inclusion in contrib/.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
