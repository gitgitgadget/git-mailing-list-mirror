From: Rafael Darder Calvo <rdarder@spiralti.com>
Subject: Re: git-push error: Cannot write keep file
Date: Tue, 24 Feb 2009 19:21:42 -0200
Organization: Spiralti
Message-ID: <49A464E6.3080802@spiralti.com>
References: <49A428B7.4000003@spiralti.com> <7v7i3fivx2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070908050509080907020101"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:23:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc4kK-0006O4-QU
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbZBXVVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbZBXVVx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:21:53 -0500
Received: from el-out-1112.google.com ([209.85.162.178]:2789 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbZBXVVw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:21:52 -0500
Received: by el-out-1112.google.com with SMTP id b25so1418924elf.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 13:21:50 -0800 (PST)
Received: by 10.151.112.12 with SMTP id p12mr199133ybm.147.1235510510353;
        Tue, 24 Feb 2009 13:21:50 -0800 (PST)
Received: from shiny.spiralti.com ([200.68.99.9])
        by mx.google.com with ESMTPS id n26sm19241396ele.2.2009.02.24.13.21.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 13:21:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7v7i3fivx2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111343>

This is a multi-part message in MIME format.
--------------070908050509080907020101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Rafael Darder Calvo <rdarder@spiralti.com> writes:
> 
>> Hello,
>> 	I am having the following error when I try to git push.
>>
>>
>> rdarder@shiny:~/Sources/promotoras$ git push origin ranto:ranto
>> Counting objects: 256, done.
>> Compressing objects: 100% (199/199), done.
>> Writing objects: 100% (213/213), 216.94 KiB, done.
>> Total 213 (delta 60), reused 1 (delta 0)
>>
>> fatal: cannot write keep file
>>
>> error: unpack failed: index-pack abnormal exit
>> To ssh://fherrero@10.7.1.20:2222/var/www/promotoras.git
>>  ! [remote rejected] ranto -> ranto (n/a (unpacker error))
>> error: failed to push some refs to
>> 'ssh://fherrero@10.7.1.20:2222/var/www/promotoras.git'
>>
>>
>> I couldn't find any significant description on the error "cannot write
>> keep file". git-fsck passes without errors in both repositories, and I
>> find no permission problems. Can anyone give me some directions on how
>> to diagnose this?
> 
> If you have access to the receiving side of the repository and the machine
> that hosts it, the debug patch attached may help.
> 
> One possibility is the receiving repository was initialized long time ago
> with an ancient git (ealier than f49fb35 (git-init-db: create "pack"
> subdirectory under objects, 2005-06-27), and never had a packfile in it
> since then.  We started creating '.git/objects/pack/' subdirectory in
> git-init only after that commit.  It was Ok for a long time because we
> lazily create "pack" subdirectory as needed, but a recent change 8b4eb6b
> (Do not perform cross-directory renames when creating packs, 2008-09-22)
> carelessly assumed that .git/objects/pack/ directory would always exist
> and tries to create files in there without making sure the leading
> directories exist.  See $gmane/110621

The receiving repository was indeed lacking a .git/objects/pack/ 
directory, but it was created with a recent (1.5.4.3) git version. I 
suspect the repo owner has deleted de dir by mistake or something.

Thank you very much for your help.

> 
>     Subject: [PATCH] Make sure objects/pack exists before creating a new pack
>     To: git@vger.kernel.org
>     Date: Wed, 18 Feb 2009 20:48:07 -0800
>     Message-ID: <7vr61vnibc.fsf@gitster.siamese.dyndns.org>
> 
> for details.
> 
> And the debug patch...
> 
>  index-pack.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/index-pack.c b/index-pack.c
> index f7a3807..acdc85f 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -802,14 +802,18 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
>  		if (keep_fd < 0) {
>  			if (errno != EEXIST)
> -				die("cannot write keep file");
> +				die("cannot write keep file '%s' (%s)",
> +				    keep_name,
> +				    strerror(errno));
>  		} else {
>  			if (keep_msg_len > 0) {
>  				write_or_die(keep_fd, keep_msg, keep_msg_len);
>  				write_or_die(keep_fd, "\n", 1);
>  			}
>  			if (close(keep_fd) != 0)
> -				die("cannot write keep file");
> +				die("cannot close the written keep file '%s' (%s)",
> +				    keep_name,
> +				    strerror(errno));
>  			report = "keep";
>  		}
>  	}
> 
> 
> 
> 
> 


--------------070908050509080907020101
Content-Type: text/x-vcard; charset=utf-8;
 name="rdarder.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rdarder.vcf"

begin:vcard
fn:Rafael Darder Calvo
n:Darder Calvo;Rafael
org:;Infraestructura
adr:;;Mitre 1017 Piso 5;Rosario;Santa Fe;S2000COU;Argentina
email;internet:rdarder@spiralti.com
title:Spiralti Rosario
tel;work:+54 341 5302041
url:www.spiralti.com
version:2.1
end:vcard


--------------070908050509080907020101--
