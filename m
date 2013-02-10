From: Jed Brown <jed@59A2.org>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Sat, 09 Feb 2013 22:45:06 -0600
Message-ID: <87y5ew6alp.fsf@59A2.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com> <5110BD18.3080608@alum.mit.edu> <7v8v72u0vw.fsf@alter.siamese.dyndns.org> <51122D9D.9040100@alum.mit.edu> <87pq0c15h3.fsf@59A2.org> <7v38x5ul4s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 05:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4OnN-0006af-VU
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 05:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761087Ab3BJEpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 23:45:17 -0500
Received: from mail-ia0-f176.google.com ([209.85.210.176]:50652 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761083Ab3BJEpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 23:45:16 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so5479819iac.35
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 20:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=NFJ07tPfQyTaUyK6gIaptNNzuKd5rch9VbHQWst/Q9Q=;
        b=qcLXDG9MGTFBObJd3S8ph/DfWa3MzIXvDlzCSGiETETaQ9x2d6ZeJAR9Hy5HgpmPbe
         7bOXqaDUm9G1VYCJ+Xd0p9Gz0oHy5zDRvmtYxjrR9VulSZaxMOsDYbyETrSq++JlBSXX
         fiDUa9ZLcdTxO8TQwX4VqIpeJInqSPVHTHVGliFbrdeFra5Be0m/M9iAEy1x56XZn8DH
         faCUCyg9Eo7xGcaQJ/mMhYSshv0R62e6wx8UcHtzO/VtbTBM0KaTM0U13fqdkEpXCvxr
         tNA1CeNhnOdc5GnK+HtnYemR2NxXnX4azO6NkAh59FfGFAJpvafv6OXZ1pZ4aqHHQwl1
         vn+Q==
X-Received: by 10.50.88.136 with SMTP id bg8mr8854577igb.96.1360471515638;
        Sat, 09 Feb 2013 20:45:15 -0800 (PST)
Received: from batura ([38.69.41.115])
        by mx.google.com with ESMTPS id uy13sm22803267igb.7.2013.02.09.20.45.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 09 Feb 2013 20:45:10 -0800 (PST)
In-Reply-To: <7v38x5ul4s.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.15 (http://notmuchmail.org) Emacs/24.2.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215897>

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure about "pushing" part, but the jc/fetch-raw-sha1 topic
> (split from the main jc/hidden-refs topic) should allow your script,
> after the client learns the set of smudged object names, to ask for
>
>     git fetch $there $sha1_1 $sha1_2 ...

Well, my out-of-band knowledge is currently the sha1 of the data
contained in the blob I want, not the blob sha1 itself [1].  After
experimenting with jc/hidden-refs, I think it already does exactly what
I want. Specifically, I set this on the server

  git config uploadpack.hiderefs refs/fat

so that 'git ls-remote' no longer transfers these refs. Then on the
client, I do

  contentid=$(sha1sum thefile | cut -f1 -d \ )
  blobid=$(git hash-object -w thefile)
  git update-ref refs/fat/$contentid $blobid

  .... more like this

  git push the-remote refs/fat/$contentid ...

and later, I can fetch specific refs using

  git fetch the-remote refs/fat/$wanted:refs/fat/$wanted ...

The client knows the desired refs out-of-band so this looks okay. It
would be convenient to have '--stdin' options to 'git push' and 'git
fetch'. Would a patch for that be welcome?


[1] The reason for using $contentid instead of $blobid in the key here
is to avoid etching the backend=git detail into the cleaned commits.
