From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] t/t7502: compare entire commit message with what was
 expected
Date: Mon, 18 Feb 2013 21:08:13 -0800
Message-ID: <20130219050813.GC19757@elie.Belkin>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 06:08:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7fRh-0005wa-2y
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 06:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab3BSFIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 00:08:20 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:38464 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3BSFIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 00:08:19 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so2784131dan.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 21:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eFGXx77qWdt6fCjkNBQVI0yxGzX9rMemejDCFAmyskQ=;
        b=XDWvTPKcdn/5CM4fb32znRf3UYDgbtDMb2nRaO7cVEbpYMXVtEtfus6kJw+Z6DpBMQ
         TwB5T3yddjk4ynJsbSO3k6sfQYsod6X9N3zbod82kEbzqNQSASPto5oHvKaXqX52ccCz
         94kMHXt0gM2bNFRFPgtcS9hCeyhIptsgJyriWTTHhEgSA9aLXA198bQG/Xd0MtVpvkGm
         5N/lGCc8gB+Ot0YTniSDluYdOTiPBOog+TcUy11FYka4ElcGOZvZivXc/xF8kQDQvtHr
         XcFnkShN4h32BRC5uByFsmc/Acczbxbh+XW9hLrEoK4GN5i3m4I3hiWvGP8zIxIUtYmZ
         6vNA==
X-Received: by 10.68.202.3 with SMTP id ke3mr12979357pbc.98.1361250498924;
        Mon, 18 Feb 2013 21:08:18 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id vq9sm16710124pbc.36.2013.02.18.21.08.16
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 21:08:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361247427-438-1-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216560>

Brandon Casey wrote:

> So, let's use the --no-status option to 'git commit' which will cause
> git to refrain from appending the lines of instructional text to the
> commit message.  This will allow the entire resulting commit message to
> be compared against the expected value.

The downside (not a new problem, but a downside nonetheless) is that
it means the test doesn't demonstrate what --cleanup=verbatim --status
will do.

How about something like this?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/t/t7502-commit.sh w/t/t7502-commit.sh
index cbd7a459..64162fce 100755
--- i/t/t7502-commit.sh
+++ w/t/t7502-commit.sh
@@ -180,15 +180,37 @@ test_expect_success 'verbose respects diff config' '
 test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo; } >expect &&
-	git commit --cleanup=verbatim -t expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
+	{
+		echo &&
+		echo "# text" &&
+		echo
+	} >template &&
+	{
+		cat template &&
+		cat <<-\EOF &&
+
+		# Please enter the commit message for your changes. Lines starting
+		# with '\''#'\'' will be kept; you may remove them yourself if you want to.
+		# An empty message aborts the commit.
+		#
+		# Author:    A U Thor <author@example.com>
+		#
+		EOF
+		git commit -a --dry-run
+	} >expect &&
+	git commit --cleanup=verbatim -t template -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
 	test_cmp expect actual
 
 '
 
 test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
+	{
+		echo &&
+		echo "# text" &&
+		echo
+	} >expect &&
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
