From: Luke Lu <git@vicaya.com>
Subject: Re: [PATCH] gitweb: speed up project listing on large work trees by limiting find depth
Date: Tue, 16 Oct 2007 21:19:08 -0700
Message-ID: <6B74E96C-37ED-4D6A-8A98-C90B61EFA181@vicaya.com>
References: <1192592725-28143-1-git-send-email-git@vicaya.com> <20071017040028.GT13801@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pasky@suse.cz
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 06:20:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii0O0-0006Vt-Go
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 06:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbXJQETp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 00:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbXJQETp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 00:19:45 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:43231 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbXJQETo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 00:19:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1623933rvb
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 21:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=rh8Rhv6oHHR6p8stehAESTBVvzNCityGSuiL/2GulvY=;
        b=bpfKlfeyHFDrzT0x26WSIbG6EFB/jjekL0Fveit+X1nkz5esFfa6RNJ2gsbbSzVgHFe+RBbkypKM2JIy09Yug432JkyNkEoIUWQ5NInIvIQTyPw65TC/xbRNMncBQ1uT1PIRfm+oKkys8FLTPo2bgOATr8GJCjxR4ivmzEyuIRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=rY79DDQkr6xfVwnPXCxqjnDWH69vWX3JxPCPMpOLPS88W8Dz03OkAPYbSfUrfadL2VnaV/wR8LBvzLK3yHDTlG9LxjjrkXv9SD82rGeJDEL1hTqjBFf7xDlCK9I8arj0DAUNtaa+31kA0TmpDbZ2GjayMJOMLjPL7NyHcxoVG+4=
Received: by 10.141.19.16 with SMTP id w16mr3946708rvi.1192594781919;
        Tue, 16 Oct 2007 21:19:41 -0700 (PDT)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id 2sm9265974rvi.2007.10.16.21.19.39
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Oct 2007 21:19:40 -0700 (PDT)
In-Reply-To: <20071017040028.GT13801@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61328>


On Oct 16, 2007, at 9:00 PM, Shawn O. Pearce wrote:

> Luke Lu <git@vicaya.com> wrote:
>> Resubmitting patch after passing gitweb regression tests.
> ...
>> @@ -1519,6 +1524,11 @@ sub git_get_projects_list {
>>  				return if (m!^[/.]$!);
>>  				# only directories can be git repositories
>>  				return unless (-d $_);
>> +				# don't traverse too deep (Find is super slow on os x)
>> +				if (($File::Find::name =~ tr!/!!) - $pfxdepth >  
>> $project_maxdepth) {
>> +					$File::Find::prune = 1;
>> +					return;
>> +				}
>
> Thanks.  I'm squashing this into your patch.  I'm not sure what
> the impact is of altering $File::Find::name in the middle of the
> find algorithm and I'm not sure we want to figure that out later.
> We found out the hard way today that altering a non-local'd $_
> in the function is what was causing the breakage.

This is generally a good advice. But tr!/!! doesn't alter the string  
at all (OK, replicates it), unless you use the /d option. tr/stuff//  
is an idiom to count stuff. Check perldoc perlop for details. I don't  
think it's necessary.

>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 48e21da..9f47c3f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1525,7 +1525,8 @@ sub git_get_projects_list {
>  				# only directories can be git repositories
>  				return unless (-d $_);
>  				# don't traverse too deep (Find is super slow on os x)
> -				if (($File::Find::name =~ tr!/!!) - $pfxdepth >  
> $project_maxdepth) {
> +				local $_ = $File::Find::name;
> +				if (tr!/!! - $pfxdepth > $project_maxdepth) {
>  					$File::Find::prune = 1;
>  					return;
>  				}
> -- 
> Shawn.
