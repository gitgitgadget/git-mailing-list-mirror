From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #02; Sun, 08)
Date: Tue, 10 Nov 2009 09:10:36 -0800
Message-ID: <905315640911100910r5116779eh24796fa5788f4aef@mail.gmail.com>
References: <7vzl6wz36r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 18:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7uFZ-00024g-U0
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 18:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261AbZKJRKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 12:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756782AbZKJRKv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 12:10:51 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:35900 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756750AbZKJRKu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 12:10:50 -0500
Received: by pwi3 with SMTP id 3so130388pwi.21
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 09:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=iS2o6sisEbaOfMy1vEPwZyUSPY6cgcJBXsoJJKXsCJA=;
        b=OWKv5hGetgRv0j1F3GFiLXHloKh71FCimRfCmhvPOQZju5klZARJkOXOVHQjkCMkpn
         P0M5b7AGv6gyoel/T1S9ntWpjU0zVkrK6OVqtI1t4M8Vu/6D+7lKNy4tfblv7V3pKIgp
         +Ory+43Xw3CYKbrK0bzwWeIqvOTM21YXjZUI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=AOADT9wKfp3esRNUSsTVy2up/KkCAP+eehWpGTiLEJfdKQa1wyXkZAd+GwfTvJuLOz
         rSLUnJ+1PXd0A/mdWO5KGzk/dNDvEhrn5h62OlI/r8t5YYGnB0OJEyo2RJiXAnBDE8Gk
         yfD4sqb62px7LbkcxIEYkWB/6sMLxtrnMsevk=
Received: by 10.142.151.9 with SMTP id y9mr32631wfd.337.1257873056075; Tue, 10 
	Nov 2009 09:10:56 -0800 (PST)
In-Reply-To: <7vzl6wz36r.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 83a98e99bdd29156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132577>

Sorry to bug you so soon again, Shawn.  Thanks for your help.

On Sun, Nov 8, 2009 at 9:18 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * sp/smart-http (2009-11-04) 30 commits
> =A0+ http-backend: Test configuration options
> =A0+ http-backend: Use http.getanyfile to disable dumb HTTP serving
> =A0+ test smart http fetch and push

OK now I'm testing on OSX with Apache/2.2.11, and curl 7.19.4.

Testing on 7f640b778f8cf87159890157a815f1d728573477, I am getting
failures starting in the third test of t5560-http-backend.sh, "static
file is ok".  I also get failures on the test after ("static file if
http.getanyfile true is ok") and in the log compare (obviously), but I
think those will go away when test 3 is fixed, so I have not looked
into them.

Specifically, the GET of info/refs makes something on my machine
unhappy.  Curl returns 18 (CURLE_PARTIAL_FILE), the test takes a long
time to fail, and the "out" file looks OK (compared to a linux machine
where the test passes) expect for "Content-Length: 37847251812411".
The exact line does not work is
curl --include http://127.0.0.1:5560/smart/repo.git/info/refs

Digging into it a bit more with gdb, the call to hdr_int() in
http-backend.c looks OK, but then something goes wrong in
format_write().  Hmmm it looks like my setup does not like PRIuMAX
with size_t, which puts some garbage in the upper bytes of
Content-Length.  Changing the PRIuMAX to a %zu allows all the tests to
pass, but that may not be the preferred solution.

Thanks,
Tarmigan
