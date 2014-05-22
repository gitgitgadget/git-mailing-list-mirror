From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 39/44] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Wed, 21 May 2014 18:42:42 -0700
Message-ID: <20140522014242.GO12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-40-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 03:42:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnI1x-00074x-Ho
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 03:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbaEVBmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 21:42:46 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:38951 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbaEVBmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 21:42:45 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so1960457pbc.16
        for <git@vger.kernel.org>; Wed, 21 May 2014 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4PpmEUcPPOXZKVFBqbcP8+4SAt7vGh4ADvFC2J/m6to=;
        b=IS8sSa2Kwd/4kkgAGD52NmjlxMvRx6CJ4fRRw6nAq3sFdMLcNOyvNuROcflZCexRdz
         p7oRw437IdGIFl56v+Bsm6mPxds2hpi8pbyLbPSRGhW0sPUlLdynK0Z3osJhJrvP8yJ6
         RxcdCxXEjQn+2uOm89nCKOxXcEwKsLogqYCzLccMgq6otTZSTxNvwt5s2TdAl0O5jkgU
         GkJY+gHhfYlvh6s2506otl7jAv/oGEqzfbj899F1ZdYMmxyDbBio3RxcOHmbFcP+1/d0
         9YvcN3BDa9mL8pkxbUgVCiBHhyAEOIfa0HqhKuXvcl80S2n+88jUDeRJjg6Rkb3YfEeR
         LSYg==
X-Received: by 10.68.173.65 with SMTP id bi1mr63285222pbc.130.1400722964996;
        Wed, 21 May 2014 18:42:44 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pr4sm10165408pbb.53.2014.05.21.18.42.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 18:42:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-40-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249868>

Ronnie Sahlberg wrote:
> --- a/refs.c
> +++ b/refs.c
> @@ -2044,6 +2044,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	int missing = 0;
>  	int attempts_remaining = 3;
>  
> +	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> +		return NULL;

Are we sure that no callers are locking a poorly named ref
as preparation for repairing it?

To see what works already in that vein, I tried:

	$ git rev-parse HEAD >.git/refs/heads/foo..bar
	$ git branch -m foo..bar something-saner
	fatal: Invalid branch name: 'foo..bar'

"git branch -m" has an explicit codepath ("recovery = 1;") to handle
this case, but it looks like it was not well tested and regressed in
v1.7.8-rc0~19^2~7 (resolve_ref(): verify that the input refname has
the right format, 2011-09-15).

Is what the recovery codepath of branch -m does misguided?  One
school of thought would be that people with malformed refs are
responsible for recovering using low-level tools like "mv" and "vi"
instead of normal git commands since normal git commands should never
have created such a bad situation.  Another school of thought would
assert that

 * git commands can have bugs
 * the format checked by check_refname_format() keeps getting stricter
   over time

which means it's nice when people can recover with 'update-ref -d'
or 'branch -m'.  It's not obvious to me what the right thing to do
here is (maybe a special flag to be attached to a ref update during
recovery?).

Hope that helps,
Jonathan
