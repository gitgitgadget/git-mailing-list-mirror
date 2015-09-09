From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/2] git-p4: print stderr if P4 read_pipe operation fails
Date: Wed, 09 Sep 2015 09:00:31 -0700
Message-ID: <xmqqbndb7fc0.fsf@gitster.mtv.corp.google.com>
References: <1441629723-90604-1-git-send-email-larsxschneider@gmail.com>
	<1441629723-90604-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 09 18:00:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZhnr-00057I-IH
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 18:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbbIIQAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 12:00:36 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36569 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbbIIQAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 12:00:35 -0400
Received: by padhk3 with SMTP id hk3so14022760pad.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lmPYn+5VWMtCbVopv7T5fcgoLRHFvX9q0qViT9a3qhM=;
        b=s0DlLJOXBknbLSBsfJumCRESCDTfHIEyMmCZbNPNAvFNEly3mKMheQVTarBGZSc8IX
         LLVNF9d4+cAbYDPie/t+SxOJHr00o/0fTKXYXJIX2ghYY38bbR+mkPE3JHVKbgzcyTlN
         mqg1Glh/lTAACh77pIejd5z77zLr7tSdZwL1lBMGQF8/DiBsbj0GRR1oW8Re35LO13Jt
         d0nVCUwWDzQ69XfUorHJKVwPQuP0slRjz83GSIHWe3chasbl0Zqvv4r9LQe/PcV7nyBI
         6L03BjMLWUQyV3r+nkjkh8DOb8gXA36CHv8/cA2tzCeXbkVczhDhRsw7vZPj3aQiBpCg
         EAow==
X-Received: by 10.68.226.73 with SMTP id rq9mr71726371pbc.60.1441814434918;
        Wed, 09 Sep 2015 09:00:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:31c8:2790:408d:8446])
        by smtp.gmail.com with ESMTPSA id by1sm7509439pab.6.2015.09.09.09.00.32
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 09 Sep 2015 09:00:32 -0700 (PDT)
In-Reply-To: <1441629723-90604-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 7 Sep 2015 14:42:02
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277556>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> If read_pipe crashes then the caller can inspect the error and handle
> it appropriately.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  git-p4.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..36a4bcb 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -134,11 +134,11 @@ def read_pipe(c, ignore_error=False):
>          sys.stderr.write('Reading pipe: %s\n' % str(c))
>  
>      expand = isinstance(c,basestring)
> -    p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
> +    p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
>      pipe = p.stdout
>      val = pipe.read()
>      if p.wait() and not ignore_error:
> -        die('Command failed: %s' % str(c))
> +        die('Command failed: %s\nError: %s' % (str(c), p.stderr.read()))

I don't know enough about the callers of this helper function to
tell offhand if that is an issue, but this looks unsafe depending on
what the process on the other side of these pipes are doing.

If it attempts to spew a lot on its standard error stream first and
then write some to its standard output, I would not be surprised it
would get stuck waiting for us to read and drain its standard error
before it can proceed to write to its standard output, and in the
meantime we would be waiting for it to say something on its standard
output, no?
