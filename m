From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 03/14] upload-pack-2: Implement the version 2 of
 upload-pack
Date: Mon, 02 May 2016 13:43:17 -0400
Organization: Twitter
Message-ID: <1462210997.4123.49.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1461972887-22100-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:43:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHsi-0001aD-U3
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbcEBRnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:43:24 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34389 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710AbcEBRnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:43:20 -0400
Received: by mail-qg0-f49.google.com with SMTP id 90so56856286qgz.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=OzrM8lqMGCnfJ6FZ7oIaGpRu6QAuye95tXiOH9CDYgY=;
        b=XZtborFaK/EBtIMZRfMZdkrs2A27mv5gajiiGAG5Hybr5OZnu/mTmAqJ1IaSKSKUyU
         SMO9yD2eGpDGJdGrcYWE80YoSfRUY1tCK/Ldyz3aRaCRkTAPhf6ttKv4TfhpsSeGUhdo
         gJP/zGwG5JhWLDTQYCYwJkQHRdPrFGaaWqecwVWE6+JWx9X6lUIuXxrk5QcG/BKOIMBI
         Bs2X3ACA8kIqvXQ19jPSzFlihdGNhCp0EkVfqNzFOe4SgANTk+kI40yg2GvZ9JpHAnD4
         fq68PojXcJ1A9jbdQPTVb41jLfKTSCRaVIvbHCRSz7VeBDZgK91m4SXhr+/c75b3cB4+
         xOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=OzrM8lqMGCnfJ6FZ7oIaGpRu6QAuye95tXiOH9CDYgY=;
        b=CLJWKvmkS5FwAbB39WNK3q5WwLTtrleqt+0Gg70sgJ+t56hHglLy2sucTwuRJI3gN3
         AIkT3MAHHIfJY+Lc1+rZ7tMhJifF8FuAcaEb6MYud5HIKkmWRkuuza+2Omf4GDPTMfxk
         tpsKSjN7S+eT1L24ONV08+/iBCIzu4cMZTuHTtJRLGRUNzHnsZwZc43IZs+wmugirZt4
         yZQWBq3Dfp0SX0omK0lhClqyW5J5rMPC2PaIT4aqoHAzANaedauiy8DV9mt4lezFx2WL
         z/yKQ23RvoIKp4IWCRkoxWznsxXqNvjm4N8dSy2OEndysTotYgEQASY6rh0S1NUxVK7N
         PF4A==
X-Gm-Message-State: AOPr4FXX+uvp5iMZ6X8pzz6ohkNAOKe65zbMPoWqtyvreeXbqwTpd2RqYgcmd2mVh/lSzA==
X-Received: by 10.141.30.201 with SMTP id t70mr35639287qhf.3.1462210999828;
        Mon, 02 May 2016 10:43:19 -0700 (PDT)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id 9sm9524457qgk.2.2016.05.02.10.43.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 10:43:18 -0700 (PDT)
In-Reply-To: <1461972887-22100-4-git-send-email-sbeller@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293248>

On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
> In upload-pack-2 we send each capability in its own packet buffer.
> The construction of upload-pack-2 is a bit unfortunate as I would
> like
> it to not be depending on a symlink linking to upload-pack.c, but I
> did
> not find another easy way to do it. I would like it to generate
> upload-pack-2.o from upload-pack.c but with '-DTRANSPORT_VERSION=2'
> set.

Couldn't we check argv[0] and use that to determine protocol?  Then we
could symlink executables rather than source code.
