From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: catch garbage after marks in from/merge
Date: Sun, 1 Apr 2012 18:12:59 -0500
Message-ID: <20120401231259.GE20883@burratino>
References: <20120401225407.GA12127@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 01:13:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SETxx-0005MN-MX
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 01:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab2DAXNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 19:13:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37882 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab2DAXNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 19:13:09 -0400
Received: by iagz16 with SMTP id z16so3361154iag.19
        for <git@vger.kernel.org>; Sun, 01 Apr 2012 16:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6i8gcCNnNvA4L/K3viGDTL/ErhTLHBuKcfHxXV2QxuQ=;
        b=jFXhC5T6DKAo9iRgCkoaiu72MNUgpptzxYQvOpTA/tkaiaOjS2Lbx8pE1+OW0jVMwX
         hkSljH4P4sfdS/+txYTBjcaZPYoweYtA2txLVMJcd/Ikpe/jwGHtfQtVPE7JuO7KyjFw
         Xn0gpHOyQu43j7BYJyiftDktrZ5LEm0dbqUc7yfMSyqlRgQ2CUbseSw8LK8AEdhjMUXL
         woiKbjQiFPuWuHLcI2+wD0fO4ew2ByMZ1mSS5kLogJmH+o7jmyrIeW1XNwmQMSf89Z8Z
         V8QpIrsHt7k0dodfHFK83Q5E2Q89Did60JHoZstTL1RvlTfHRWm9Q3sx1y5NCdPq5f11
         dOZw==
Received: by 10.50.193.234 with SMTP id hr10mr3928161igc.14.1333321988844;
        Sun, 01 Apr 2012 16:13:08 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gs4sm10229676igc.8.2012.04.01.16.13.07
        (version=SSLv3 cipher=OTHER);
        Sun, 01 Apr 2012 16:13:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120401225407.GA12127@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194492>

Hi Pete,

Pete Wyckoff wrote:

>     from :1M 100644 :103 hello.c
>
> It is missing a newline and should be:
>
>     from :1
>     M 100644 :103 hello.c

Good idea; thanks.

I agree that this at least deserves a warning and probably should
error out.

[...]
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2537,8 +2537,16 @@ static int parse_from(struct branch *b)
>  		hashcpy(b->branch_tree.versions[0].sha1, t);
>  		hashcpy(b->branch_tree.versions[1].sha1, t);
>  	} else if (*from == ':') {
> -		uintmax_t idnum = strtoumax(from + 1, NULL, 10);
> -		struct object_entry *oe = find_mark(idnum);
> +		char *eptr;
> +		uintmax_t idnum = strtoumax(from + 1, &eptr, 10);
> +		struct object_entry *oe;
> +		if (eptr) {
> +			for (; *eptr && isspace(*eptr); eptr++) ;
> +			if (*eptr)
> +				die("Garbage after mark: %s",

The implementation seems more complicated than it needs to be.  Why
allow whitespace after the mark number?

Curious,
Jonathan
