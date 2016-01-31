From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: git log -g bizarre behaviour
Date: Sun, 31 Jan 2016 12:52:24 +0100
Message-ID: <1454241144.2822.7.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 12:53:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPqYv-0007z8-Tg
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 12:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbcAaLwr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2016 06:52:47 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33547 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757375AbcAaLw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:52:26 -0500
Received: by mail-wm0-f47.google.com with SMTP id l66so35346752wml.0
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 03:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:content-type:mime-version
         :content-transfer-encoding;
        bh=oSGRPQM7Q+R4FxqslnzgbOyI3XubD6d6JV5rpxOF0Ro=;
        b=HE2TcUhyPmtZ1l007S2bCNxhVviNhPIhd3udAkUVI7XvcqUqghCIx3OIDLUpneNida
         rXZ91kXCGEdJ5Dy+A86/rb2DV6spdVG7EWGazYc31rNMD+rQltWoCsG5fOJe5bicJIYO
         JmN2nUi/5FRspOfRCN1Ek9cRfzpu812ZkQNfXgxa5XssES+oSJTeoGedu+iyPR8E+JSM
         aMbRMt3S0ZUaCKuZwVrx2ekQ2oiPjiw8ASjxr3OGcTbvjAgysIVk0N62Zg3hicaEv2Sl
         5PWGMfc6NPW9T1+8Oj9bNmibb7u+YP5rO74+VhvJ4xDVVD6lSwd9nE1aMz2PK+ZvW8nc
         ItFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:content-type
         :mime-version:content-transfer-encoding;
        bh=oSGRPQM7Q+R4FxqslnzgbOyI3XubD6d6JV5rpxOF0Ro=;
        b=HNEnCTttEdSHS9nYGQMVGzuLWZqpCOaaCoSw3DPYtYmeTxIE+0iaO7U74lHvGp4XDu
         7YYEpn5fnvyxUiD588TJq2rEaazmCPPQ4wgbMqZpV63t3x/0tTVP4E5P8lqzEeCiaHnM
         OpgROTaOCspsQbC9wA7JmLAusvgnIjKs7fJuiZobJirGoUQwCqwnyi68dpNeR96z/3DO
         /fNvjDyxX5ljsSJJ77NqfQuUUBnOU4mwBrQ63EQt9NlbB7rcHFrdzZjmrAgbXiDlT+YB
         b6tCDC+OAxePdG78OiMKKgHDy6akzui6LdOkqRrn6bfOAY+nV2xbUmmSCVGgXvJkgCoh
         Ou5A==
X-Gm-Message-State: AG10YOSqKhk87CsS9bufYz4BrfXfP3v+fpPHlSGuMgmFMEijg6LEmMrRebBYYLXx1c7oiQ==
X-Received: by 10.28.142.8 with SMTP id q8mr6327083wmd.47.1454241145666;
        Sun, 31 Jan 2016 03:52:25 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id g187sm6507187wmf.8.2016.01.31.03.52.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2016 03:52:24 -0800 (PST)
X-Mailer: Evolution 3.18.3-1ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285141>

I'm attempting to understand the log [-g] / reflog code enough to
untangle them and make reflog walking work for more than just commit
objects [see gmane 283169]. I found something which I think is wrong,
and would break after my changes.

git log -g HEAD^ and git log -g v2.7.0^ give no output. This is
expected, as those are not things that have a reflog. But git log -g
v2.7.0 seems to ignore -g and gives the normal log. git reflog v2.7.0
does something even more bizarre:

$ GIT_PAGER=3D git reflog v2.7.0=C2=A0
7548842 (tag: v2.7.0, seveas/master, origin/master, origin/HEAD) 3e9226=
a 833e482 (tag: v2.6.5, gitster/maint-2.6) e3073cf e002527 e54d0f5 06b5=
c93 34872f0 5863990 02103b3 503b1ef 28274d0 (tag: v2.7.0-rc3) aecb997 7=
195733 e929264 ce858c0 5fa9ab8

Yes, that's a humongous line (I've only copied parts of it).

I'd like to make git log -g / git reflog abort early when trying to
display a reflog of a ref that has no reflog. Objections?

--=20
Dennis Kaarsemaker
www.kaarsemaker.net
