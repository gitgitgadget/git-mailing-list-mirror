From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] lockfile: introduce alloc_lock_file() to avoid
 valgrind noise
Date: Wed, 6 Oct 2010 15:21:30 -0500
Message-ID: <20101006202130.GB2118@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
 <20101002083216.GC29638@burratino>
 <7vocb7yte4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 22:24:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3aXe-0005B7-Vk
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 22:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792Ab0JFUYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 16:24:38 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48869 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758083Ab0JFUYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 16:24:37 -0400
Received: by qyk8 with SMTP id 8so30289qyk.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zWEjNpdsWf6O6J8/rf1RaTDtLELrPY9nFJIKOUPz6Mw=;
        b=YmOyYGLcUI4K7UsZic4xK3TgSJRABtgeSGJ9Kv1ZJ06XZzH8UGtG6k1gsenZfZRf3h
         Qzvcm5WSMVWMDiM1cjywM4QnOF7MbSJzkL/5d48nJ/iJ0vnqBN+GRhkErWKMML5EDcLT
         BowAI/W5fwzuBGX/ZWiQL2tiIYOtfACxT9E64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nSEn9LKyCu9+lvTjp70zGb4TF95++lg3TzoxOZ2Uw/4ZwGhSaUt6NZBQkBHHb3BDUn
         6xT9DjdejNDBLRktcvrHP2rE/hXhW/hBczG7rANOfesARy9r7ZhL/ECvU1YJeCNa1cef
         BS09aenPXAvttNYMZ4g2gkn0/8whfeukahD04=
Received: by 10.229.186.137 with SMTP id cs9mr9180852qcb.71.1286396676450;
        Wed, 06 Oct 2010 13:24:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id w5sm603994vcr.6.2010.10.06.13.24.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 13:24:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vocb7yte4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158304>

Junio C Hamano wrote:

> Hmm, I am getting
> 
>     cc1: warnings being treated as errors
>     lockfile.c:189: error: 'optimize' attribute directive ignored
>     make: *** [lockfile.o] Error 1
> 
> from this patch with gcc (Debian 4.3.2-1.1) 4.3.2

Unfortunate.  With gcc 4.5 it works, but that isn't too useful.

> Aren't "struct lock_file" instances supposed to be reachable from the
> linked list, i.e. lock_file_list?  Why does valgrind consider that
> elements on that list are leaked in the first place?

At exit, we walk the lock file list and clear it in the process.
Which suggests a cleaner workaround (thanks!):

 static void remove_lock_file(void)
 {
	pid_t me = getpid();
+	struct lock_file *p = lock_file_list;

-	while (lock_file_list) {
-		if (lock_file_list->owner == me &&
-		    lock_file_list->filename[0]) {
-			if (lock_file_list->fd >= 0)
-				close(lock_file_list->fd);
-			unlink_or_warn(lock_file_list->filename);
-		}
-		lock_file_list = lock_file_list->next;
+	while (p) {
+		if (p->owner == me &&
+		    p->filename[0]) {
+			if (p->fd >= 0)
+				close(p->fd);
+			unlink_or_warn(p->filename);
+		}
+		p = lock_file_list->next;
	}
