From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Sun, 13 Jul 2014 12:09:25 +0700
Message-ID: <CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com> <1405140276-32162-4-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 07:10:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6C32-0000mX-9v
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 07:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbaGMFJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 01:09:57 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:50876 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbaGMFJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 01:09:56 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so2406168qcv.12
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 22:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WvSA46ESNnu+hK/XCf0KCnBhW3BJwo1z/rK3fZenf3Q=;
        b=oBP+wa+HcIpXRPAevCJJ6pE51yu+36O7hqi8nbIIhZykqyVXiy3p99ASjRApot5DNM
         ZG/pombC7Lcc97bp1T9r1T5EdMlqJqz3E81vCfN/hSH/aN62PO6EcNxFOSv9lPl8wo7p
         utX9FZ1zTkyIwsHnCRQ/c7HPLJOEjDYka63w2k20qTsoI9z7A6+SDsCcl5oH8HcrW5PX
         jUOi/m2uJo3R6n1sdulFNjapBjxL3t5TlPwgeeQM57TaZyhCizs+ydumFCGZvwmhNkI7
         Ry3VPOptalElpIOFPqI/8RlHJHL9s5mnQCQb50gaiRFGoytkQPWh7s0cVKfWnGF3ioRw
         FY/A==
X-Received: by 10.224.137.9 with SMTP id u9mr12625831qat.24.1405228195285;
 Sat, 12 Jul 2014 22:09:55 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 12 Jul 2014 22:09:25 -0700 (PDT)
In-Reply-To: <1405140276-32162-4-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253435>

On Sat, Jul 12, 2014 at 11:44 AM, David Turner <dturner@twopensource.com> wrote:
> @@ -342,6 +342,15 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>
>                 discard_cache();
>                 read_cache_from(index_lock.filename);
> +               if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
> +                       fd = open(index_lock.filename, O_WRONLY);
> +                       if (fd >= 0)
> +                               if (write_cache(fd, active_cache, active_nr) == 0) {
> +                                       close_lock_file(&index_lock);

If write_cache() returns a negative value, index.lock is probably
corrupted. Should we die() instead of moving on and returning
index_lock.filename to the caller? The caller may move index.lock to
index later on and officially ruin "index".

> +                       }
> +               }
> +               else
> +                       fprintf(stderr, "FAiled to update main cache tree\n");

make the above line something like this for i18n support:

fprintf_ln(stderr, _("Failed to update main cache tree"));

>
>                 commit_style = COMMIT_NORMAL;
>                 return index_lock.filename;
-- 
Duy
