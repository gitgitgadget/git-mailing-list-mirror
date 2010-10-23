From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/10] Change incorrect "remote branch" to "remote
 tracking branch" in C code
Date: Sat, 23 Oct 2010 13:58:43 -0500
Message-ID: <20101023185843.GJ21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-8-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 21:02:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jMa-0004gK-2X
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 21:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758764Ab0JWTCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 15:02:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36183 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758758Ab0JWTCf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 15:02:35 -0400
Received: by ywk9 with SMTP id 9so1418999ywk.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1sZTofVks3o+F8yWI1264OLgJ6afV+QQTASbZXDvg9k=;
        b=UXesSqZj6Z9FqX2gD5bKZ8sm2MSuQp+2+cKtK++UaSRRIkOHmWMgIwPiKwaVbNEgT7
         Vk0fqVU9KqNcvWPxremveDmgLRv4w7h2z4LzZKUsOr7A5N3CJzg38JSgXc02reT2nvs7
         OCy9243meS8hwZAEo+dmuPgZQDyYwHOA/sRbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E3gzdhUuT86z/CR8yV2tZn6Abkp+AeudxOBG0zz5aqdD+tn0V1eJWqta88E7QyrJPl
         JFjdyLXQOdxIxtOujUImfZN26ttUnLwHYp6c07KvLkYfOuItB9rQnW5+crcR6MYJrL27
         uTrkj5zsbxn3nIDsh88EToMWBICpScTaZcY58=
Received: by 10.150.50.11 with SMTP id x11mr9349124ybx.106.1287860553966;
        Sat, 23 Oct 2010 12:02:33 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r18sm4757159yba.15.2010.10.23.12.02.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 12:02:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287851481-27952-8-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159816>

Matthieu Moy wrote:

> --- a/branch.h
> +++ b/branch.h
> @@ -22,7 +22,7 @@ void create_branch(const char *head, const char *name, const char *start_name,
>  void remove_branch_state(void);
>  
>  /*
> - * Configure local branch "local" to merge remote branch "remote"
> + * Configure local branch "local" to merge remote-tracking branch "remote"
>   * taken from origin "origin".
>   */
>  #define BRANCH_CONFIG_VERBOSE 01

Is this really more accurate?  I thought what install_branch_config does
is to configure local branch "local" as downstream to remote branch
"remote" from origin "origin".  That means:

 - "git pull" fetches that remote and then merges the corresponding
   remote-tracking branch
 - "git remote show" compares the local branch to the remote branch
 - "git branch -v" compares the local branch to the remote-tracking
   branch

and so on.

> index 3b0b614..4243ef0 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -359,7 +359,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  			what = rm->name + 10;
>  		}
>  		else if (!prefixcmp(rm->name, "refs/remotes/")) {
> -			kind = "remote branch";
> +			kind = "remote-tracking branch";

For use by "git merge" and other "git fmt-merge-msg"-like consumers.  Good.

> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -791,9 +791,9 @@ static int rm(int argc, const char **argv)
>  
>  	if (skipped.nr) {
>  		fprintf(stderr, skipped.nr == 1 ?
> -			"Note: A non-remote branch was not removed; "
> +			"Note: A non-remote-tracking branch was not removed; "
>  			"to delete it, use:\n" :
> -			"Note: Non-remote branches were not removed; "
> +			"Note: Non-remote-tracking branches were not removed; "
>  			"to delete them, use:\n");

This wording is ugly.  Maybe something to this effect would be better?

	Note: A ref outside the refs/remotes/ hierarchy was not removed:

> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -107,16 +107,16 @@ test_expect_success 'remove remote' '
>  )
>  '
>  
> -test_expect_success 'remove remote protects non-remote branches' '
> +test_expect_success 'remove remote protects non-remote-tracking branches' '

Maybe:

	test_expect_success 'remove remote protects local branches' '

since that is what is important in practice.
