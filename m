From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: Am I doing something wrong?
Date: Wed, 21 Dec 2005 16:03:58 -0500
Organization: Network Appliance, Inc.
Message-ID: <43A9C33E.2070807@citi.umich.edu>
References: <86k6dyxuke.fsf@blue.stonehenge.com>	<7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>	<864q52xrm6.fsf@blue.stonehenge.com>	<7vmziub9yw.fsf@assigned-by-dhcp.cox.net>	<86zmmuwbzh.fsf@blue.stonehenge.com>	<7vhd92b90w.fsf@assigned-by-dhcp.cox.net> <7vvexi8bo9.fsf@assigned-by-dhcp.cox.net>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040208090000070800090201"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 22:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpB7y-0003VA-At
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 22:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVLUVD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 16:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVLUVD7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 16:03:59 -0500
Received: from citi.umich.edu ([141.211.133.111]:10308 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751213AbVLUVD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2005 16:03:59 -0500
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by citi.umich.edu (Postfix) with ESMTP id 978731BC6A;
	Wed, 21 Dec 2005 16:03:58 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvexi8bo9.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13899>

This is a multi-part message in MIME format.
--------------040208090000070800090201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

maybe the Linux kernel repository needs the same treatment.  i'm getting 
the "all zeros" commit error message when trying to pull from it.


Junio C Hamano wrote:
> It turns out to be a stupid off-by-one error in http-fetch.c.
> The objects/info/packs file has the following:
> 
>         $ cat objects/info/packs
>         P pack-46ff81b11ed16ed38caa4aada913cb08c00185b2.pack
>         P pack-05f611b3b8198b262acdf678584d365f8e879aec.pack
>         P pack-740c99c0be6734adbd130737dec2608dc4682761.pack
>         $
> 
> The code that parses this in http-fetch had an off-by-one, and
> incorrectly thought that the last entry was incomplete.  This
> problem did not surface earlier, because objects/info/packs file
> used to have other information after all the P lines, but
> http-fetch was not interested in was skipping them.  The latest
> update-server-info stopped producing those extra lines.
> 
> As a band-aid, I just ran this command at the server that public
> ones mirror from:
> 
> 	$ echo >>objects/info/packs
> 
> The change seems to have mirrored out already, and my "broken"
> client before the attached patch successfully fetches from
> there, so hopefully things would work OK for you as well.
> 
> I also have to add some code to server-info.c, to append an
> empty after objects/info/packs file to work around this bug in
> the deployed http clients.
> 
> Thanks for your help in diagnosing and fixing this problem.
> 
> -- >8 --
> [PATCH] http-fetch.c: fix objects/info/pack parsing.
> 
> It failed to register the last pack mentioned in the
> objects/info/packs file.  Also it had an independent overrun
> error.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> git diff
> diff --git a/http-fetch.c b/http-fetch.c
> index ad59f1c..3cd6ef9 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -658,7 +658,7 @@ static int fetch_indices(struct alt_base
>  		switch (data[i]) {
>  		case 'P':
>  			i++;
> -			if (i + 52 < buffer.posn &&
> +			if (i + 52 <= buffer.posn &&
>  			    !strncmp(data + i, " pack-", 6) &&
>  			    !strncmp(data + i + 46, ".pack\n", 6)) {
>  				get_sha1_hex(data + i + 6, sha1);
> @@ -667,7 +667,7 @@ static int fetch_indices(struct alt_base
>  				break;
>  			}
>  		default:
> -			while (data[i] != '\n')
> +			while (i < buffer.posn && data[i] != '\n')
>  				i++;
>  		}
>  		i++;
> 
> Compilation finished at Wed Dec 21 11:40:06
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------040208090000070800090201
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Open Source NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://troy.citi.umich.edu/u/cel/
version:2.1
end:vcard


--------------040208090000070800090201--
