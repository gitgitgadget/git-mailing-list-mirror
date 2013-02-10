From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 18:22:05 +0700
Message-ID: <20130210112205.GA28434@lanh>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
 <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
 <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 12:21:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Uyf-0003Gp-5Q
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 12:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab3BJLVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 06:21:21 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44824 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab3BJLVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 06:21:20 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so2769468pab.33
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 03:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rTVFFZbVPAEgNgMCEQL8lbF55bZlsesheJrAxFT/vMM=;
        b=mPoJGXqSUSOCVl3BIsXBQk3aG8lEpzP4ATQj0BPUJcK0J58L+7XeGi9xILcpjnNZm8
         axknAx50dR9QCou7cKuaQUs+CAhFhFKsRcKyJaLc9l3vrfx4BtDsbwJ7qxnezAAo2E3W
         nELGjvb+GGfXfb7/1klU5ilFT+ONPaZkNi1+6IzuSrwWPklCyo87BC0VTPSSX1v95ke5
         0gS56euKkyDJJ33Gui1ovj4KNYqXQ4dGdIQzINifhImY3BgJjSkrnfjNm7YlI5Ju6dum
         iFmswDE4qQvsdnn0ldzJUsKmzENKDJIvu7SyjYn+DE6/58zAy6qJ9s/BQKNn7NfzlTcN
         Y8iQ==
X-Received: by 10.68.190.6 with SMTP id gm6mr10043679pbc.103.1360495280432;
        Sun, 10 Feb 2013 03:21:20 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id c3sm19695043pax.9.2013.02.10.03.21.16
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 03:21:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Feb 2013 18:22:05 +0700
Content-Disposition: inline
In-Reply-To: <20130210111732.GA24377@lanh>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215901>

On Sun, Feb 10, 2013 at 06:17:32PM +0700, Duy Nguyen wrote:
> The following patch eliminates untracked search code. As we can see,
> open+getdents also disappears with this patch:
> 
> 0.462909 40950 lstat   0.462909 40950 lstat
> 0.003417 129 brk       0.003417 129 brk
> 0.000762 53 read       0.000762 53 read
> 0.000720 36 open       0.000720 36 open
> 0.000544 12 munmap     0.000454 33 close

.. and the patch is missing:

-- 8< --
diff --git a/dir.c b/dir.c
index 57394e4..1963c6f 100644
--- a/dir.c
+++ b/dir.c
@@ -1439,8 +1439,10 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
+#if 0
 	if (!len || treat_leading_path(dir, path, len, simplify))
 		read_directory_recursive(dir, path, len, 0, simplify);
+#endif
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
-- 8< --
