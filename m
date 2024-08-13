Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B3174EEB
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540002; cv=none; b=DMY4TRKxy1Q3IQDxh/fLQhNHW/g9p1IHS3TXKGMgO9t0em2djQ/TqNb2SvsKIWG8oOyIcoeGlzg82A4PlvcERXu2t5hRqh3MfMkDQxRt0N80ycOetetMS78B8gJSFtR+rzjS0jVF9mW+boKvtXnKTG07hIxcFP98ORmYZlF8PC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540002; c=relaxed/simple;
	bh=booAwgYnAa44PMNzehud1DrcN8uXm23y07B/GbRd9BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpXQn+TH9bx6ocp4wSo82N8YWZkLVrULKh7VHS+UMNfnUhDH6+MhndTS27tp0LwL9jUejEnEfDo/RrRtahmOiMeTS1BqBuxeEs1cDg5WI+a+ETbNJvjXYVk1NjUK07e9fLIF3AFmhab4hpEii2+3PDZBSWVYszflKoTXmMJG01Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=QGAK+NfX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="QGAK+NfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723539992; x=1724144792;
	i=oswald.buddenhagen@gmx.de;
	bh=DbJ4wYY3xRuNVftmv3XzFHVHSTK7wfp0G4/MnTX9gCc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QGAK+NfX845/umMV6Y+c4Ns2a6rc1O+0Eiz9YIUrYXZo6DfKnG8y9WVqboy9DOjv
	 vj92xGbTMluO+6sxqp0a1jKxTaIliJ++3X/zCz7aUGvhShHyVvyyygZlU/JbQ+/GQ
	 WPu1Pu+uluGQbAIhvcEXdTO2mYUqQ7AChnmzNoJGEQbxDDOMfHGfvk0YAixh0xquS
	 2zEFa8QUwInMZHor42wt1CvFJfdRXq77Hr+1ULwjrAVHPmUtP7wMfo+5rUYhOmkZy
	 ERBxc94g9fSI8IpRT6YDKZfwVRINrBsbmJv9tdBjVPsI2QiDXtte9qQo+ehN7rRsY
	 BGtCVMso2nQC0QZLgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.112]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1s3eO33jjA-00bNXz; Tue, 13
 Aug 2024 11:06:31 +0200
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1sdnU7-klF-00; Tue, 13 Aug 2024 11:06:31 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Brian Lyles <brianmlyles@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sean Allred <allred.sean@gmail.com>
Subject: [PATCH 1/2] git-gui: strip comments and consecutive empty lines from commit messages
Date: Tue, 13 Aug 2024 11:06:30 +0200
Message-ID: <20240813090631.1133049-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.46.0.180.gb23db42a00
In-Reply-To: <20240813090631.1133049-1-oswald.buddenhagen@gmx.de>
References: <20240813090631.1133049-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oV1DaxjmT2fwbxjKLEBtixhwjs3i5l2V/JAWrRNpCpKJvX8RF7a
 M8Z2cwTPW3/h9suBDJkkyjFh90NTXAv45z/G+z5gSya5mMLZ7+kO2dA5NNjvywkCH5wCIPI
 hPn6EtwZeFpQafIywWw6PoZhWpT+2UJ3cwaXb+oEM4Bn8QJFB8aLMQ4Bdv1lHPYGJ5pxlfS
 xi6Y2dkS07BtsUtGpdplw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zKwaeE59/2s=;RqM4Ta4MOWYLnb3qoODFq0UCoJr
 ynG6RaXauYJ8pCav72JriQEPFKE94AZ9rvMBkuGqdflV6OE6+O1tKRbQ9opLZ/VMoMzdUGp+d
 08xPeSfUcQEvz+dWSAwTSgG8yrwnuTd8pQol38gq7Lx3BgT+5B42Y+7q2remXd6cZQRkzXElG
 HKbmcBB8WLh5RFXs45GVlya3zQ7EyX3EReyfuc+5gjNoBS1avnZyNfjxPXJQV8ilrfycivwOU
 J874pZ9OHf4Mi/iLK/epBZOfVgqw9NJAZSACI01hj4Gko0basmLnyrcHHERL6hYwgU/hsqxue
 CeIWBa9KoD8yOYKijVoFt0ROXCMgKrtq+5+NmNL+B0bF/l4B2+qbEk36D9bqFkfn/jTJF/YAn
 GAIQfGxKse2B8V2p4psBwkuMWrHRo8jZHMDPZ1loocWzHHtqAfJBefz98jwLC86vqFlEXmJnY
 iIwRzLst4gad9Iz0bL2uxMV9+kv3TNk9dkxFkaGZC2AikLo/aVQCSIxk1tmJCAGIifUjnluGj
 M/5T4rLlYpx1lnvbpPqQc2RaEPoiF+Fe3N3oVYhpr2yF/cS/rl/mcD7NTmAGiFGHOq3izfe4r
 ZXvX4RPODmQ9zbcW0yaSCzVJypLKUQko2eYQkAkWsCsWILM7rmrxSeFWCm8BKh5j2KOpru9ro
 MSE1GNHsncEpv9BW/n74Lg4V+nzXmN3bHia0/An+4wUWBwNwNvJv+P4xc9+hQrq4Dc84fYST+
 ZyPSIiWWUJdTv47sDuNG//w/wzU4iaVcHm2qe23LknMfctaOm0sqzUH/U/nDzHZ6Tw7med75n
 24aJiYhEzkrXOEpsS0q50yySvpW+JhBAd0KAbU+uA3M6Q=

This is also known as "washing". This is consistent with the behavior of
interactive git commit, which we should emulate as closely as possible
to avoid usability problems. This way commit message templates and
prepare hooks can be used properly, and comments from conflicted rebases
and merges are cleaned up without having to introduce special handling
for them.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---

Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Brian Lyles <brianmlyles@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sean Allred <allred.sean@gmail.com>
---
 git-gui/lib/commit.tcl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 11379f8ad3..f00a634624 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -209,6 +209,10 @@ You must stage at least 1 file before you can commit.
 	#
 	set msg [string trim [$ui_comm get 1.0 end]]
 	regsub -all -line {[ \t\r]+$} $msg {} msg
+	# Strip comment lines
+	regsub -all {(^|\n)#[^\n]*} $msg {\1} msg
+	# Compress consecutive empty lines
+	regsub -all {\n{3,}} $msg "\n\n" msg
 	if {$msg eq {}} {
 		error_popup [mc "Please supply a commit message.
=20
--=20
2.46.0.180.gb23db42a00

