From: William Throwe <wtt6@cornell.edu>
Subject: [PATCH] Bad file descriptor on filtering empty files
Date: Fri, 19 Dec 2014 17:41:58 -0500
Message-ID: <87sigbmfd5.fsf@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 23:42:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y26FU-0008IG-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 23:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbaLSWmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 17:42:12 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:50337 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaLSWmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 17:42:11 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so3202235wiw.9
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 14:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version:content-type;
        bh=nmquKsBgC05ZxiaegM9aCR6ND1wMZC6ZltdxDyoOlJk=;
        b=dteGwEHXzDPuLgJ2VUULhk1TPr6GFYvC+/xrHh+PdgwCINy12bkuyJJar6/atv1jlp
         BTFSPN1UXH5ME6E+z3L/ajmPevsV59p1jsK88hz6IPOCn/Y8nld5hQb5isJspRdzEFuU
         2lDuOcQGjmYkW7+Sc90GUTSePws4zG+/mk2h92IP+uA2rou1x5ThILz1SxahLxuhxG1s
         a4HxuWMQ1NikGtAAQv7OlqJ2iuyA2oQEkfWEmkuXrPt2C4M0gN/23+TzwJpBaX1VaQyL
         6SNrbdvSyJTeiy0iBzDzgi9UPn2D2rH0nRwFO6IINBU6ZmboN6gGQ8b+kawNIRQpEZFC
         fb9w==
X-Gm-Message-State: ALoCoQk3kER5AZQMU6JTx9E24HCfcJWrmXOGid4LlmCFk/Ta9vbqGNSWZ/t4Zrpz/OJGxnL5fzJX
X-Received: by 10.180.88.165 with SMTP id bh5mr9822573wib.77.1419028930358;
        Fri, 19 Dec 2014 14:42:10 -0800 (PST)
Received: from carcharoth (cpe-104-229-209-66.twcny.res.rr.com. [104.229.209.66])
        by mx.google.com with ESMTPSA id gl11sm14266022wjc.40.2014.12.19.14.42.08
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 14:42:09 -0800 (PST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261597>

In git 2.2.0 (also tested on 2.2.0.65.g9abc44b), if an external
smudge/clean filter is called on an empty file git reports something
like:
error: copy-fd: read returned Bad file descriptor
error: cannot feed the input to external filter cat
error: external filter cat failed

Test case:

mkdir bug
cd bug
git init
git config filter.cat.clean cat
git config filter.cat.smudge cat
echo '* filter=cat' >.gitattributes
touch a
git add a


This started in 9035d75a2be9d80d82676504d69553245017f6d4, which
introduced the possible call to copy_fd in code called from
apply_filter.  It appears that NULL as the src argument to apply_filter
is being used both as a sentinel value to indicate that the fd should be
used instead and also as a representation of the contents of an empty
file.  I suggest switching to using fd == -1 as the sentinel as shown in
the patch below.

Thanks,
Will


diff --git a/convert.c b/convert.c
index 9a5612e..0509ac1 100644
--- a/convert.c
+++ b/convert.c
@@ -355,7 +355,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	if (params->src) {
+	if (params->fd == -1) {
 		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
 	} else {
 		write_err = copy_fd(params->fd, child_process.in);
