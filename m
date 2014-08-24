From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Sun, 24 Aug 2014 17:10:12 +0200
Message-ID: <53FA0054.5060808@gmail.com>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Arjun Sreedharan <arjun024@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 17:10:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLZR7-00011j-S4
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 17:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbaHXPKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 11:10:14 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:40543 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaHXPKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 11:10:13 -0400
Received: by mail-we0-f171.google.com with SMTP id p10so12277508wes.30
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6YJnuu0yvamh8lvfqRWhEz1XA6IWrmtXsHkcoGw4EFM=;
        b=MkpH7xLn5qYcbMdvOyJDmnRZ+XkmvcjNudp9o7CgvhIgaQFpXNMREVvLfDKh7/ID/Y
         WkU9RaNYF7js+wG6fVKSoDj3QmdjbJ67KFD8pguwDRzB0ALUNUEuMt6N1ETF2s2dlGc0
         yw+NlXnkbv6u+4Pd+rQY+O4WMOU1R48AZp0K4HjgfryKGtk2dz2DwOKaUWXDlRP0P2X4
         Bv22yz18jeX4bkTW88aNu33cIPO8BpQxNtpEYPtlNucIZPI7wUQ3lV+n3xs6dAd1QZCZ
         AsovRgDpCnMUSiS1BycdCZnb3JDTHj3KRXhvyXR+NmoOH0IXnKTtV3el0dTNBg1iyMn5
         ly/w==
X-Received: by 10.194.184.230 with SMTP id ex6mr2946945wjc.83.1408893012048;
        Sun, 24 Aug 2014 08:10:12 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id gd4sm21365396wib.3.2014.08.24.08.10.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Aug 2014 08:10:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255792>

On 24.08.2014 16:17, Arjun Sreedharan wrote:
> Find and allocate the required amount instead of
> allocating extra 100 bytes
> 
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
> ---
>  bisect.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/bisect.c b/bisect.c
> index d6e851d..c96aab0 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -215,10 +215,13 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>  	}
>  	qsort(array, cnt, sizeof(*array), compare_commit_dist);
>  	for (p = list, i = 0; i < cnt; i++) {
> -		struct name_decoration *r = xmalloc(sizeof(*r) + 100);
> +		char name[100];

Would it make sense to convert the 'name' into a git strbuf?
Please have a look at Documentation/technical/api-strbuf.txt

> +		sprintf(name, "dist=%d", array[i].distance);
> +		int name_len = strlen(name);
> +		struct name_decoration *r = xmalloc(sizeof(*r) + name_len);
>  		struct object *obj = &(array[i].commit->object);
>  
> -		sprintf(r->name, "dist=%d", array[i].distance);
> +		memcpy(r->name, name, name_len + 1);
>  		r->next = add_decoration(&name_decoration, obj, r);
>  		p->item = array[i].commit;
>  		p = p->next;
> 
