From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 38/44] refs.c: pack all refs before we start to rename
 a ref
Date: Wed, 21 May 2014 16:57:41 -0700
Message-ID: <20140521235741.GN12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-39-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 01:57:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnGOL-0000lb-Sn
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 01:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbaEUX5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 19:57:45 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:59171 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbaEUX5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 19:57:45 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so1873138pab.40
        for <git@vger.kernel.org>; Wed, 21 May 2014 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JH5McMGW+JaMzhvcD2N4ufB0hL8Yfcx9BqLoUeqGdOE=;
        b=OZHJVcO18r9AkdjxSIFvL9vRosXjZLRwLStU+hmwccHk9xFSaxu5o8MnN7Q2f3f/1D
         QkJXJFb2TdlBhOhLaNu6Vis+XQB0urYrsplY00jwCUedE6B9tHlB7meTPxNHlGrlfSg1
         pDrQGF5loTJO8wDj2NI3Rbz2GuxcIOF/njsPtvCW8XJwATSaqv7sJHNNwVz+iijLk238
         j4ZQQCUR0yLj5L8dF9dm1ytJJEZsI3dTqI8UDAdWW9oej1VT860kvtgtdVsEAJKH5hkr
         ABG+TSeUaa774J+JG1YDtI3+JxBNDMrfkak95cQYBKS1O0wbXFqbs6PyHRC+FiMbT1kb
         pWyQ==
X-Received: by 10.66.153.80 with SMTP id ve16mr63097194pab.143.1400716664677;
        Wed, 21 May 2014 16:57:44 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pz10sm5581200pbb.33.2014.05.21.16.57.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 16:57:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-39-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249862>

Ronnie Sahlberg wrote:

> This means that most loose refs will no longer be present after the rename

Is this to handle the "git branch -m foo/bar foo" case or for some other
purpose?

[...]
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -289,7 +289,7 @@ test_expect_success 'renaming a symref is not allowed' '
>  	git symbolic-ref refs/heads/master2 refs/heads/master &&
>  	test_must_fail git branch -m master2 master3 &&
>  	git symbolic-ref refs/heads/master2 &&
> -	test_path_is_file .git/refs/heads/master &&
> +	test_path_is_missing .git/refs/heads/master &&
>  	test_path_is_missing .git/refs/heads/master3

It's kind of silly that this test is mucking about in the .git directory
at all.  Shouldn't the check be something like

	git rev-parse --verify refs/heads/master &&
	test_must_fail git symbolic-ref refs/heads/master3 &&
	test_must_fail git rev-parse refs/heads/master3

?
