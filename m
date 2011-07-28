From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/WIP 4/7] fast-import: fix data corruption in store_tree
Date: Thu, 28 Jul 2011 09:42:39 +0200
Message-ID: <20110728074239.GA5980@elie>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
 <1311828370-30477-5-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 09:43:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmLFJ-0004Oy-PX
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 09:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab1G1HnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 03:43:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57787 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab1G1Hm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 03:42:59 -0400
Received: by fxh19 with SMTP id 19so1005354fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q9fdZaooCKtbTPJ2YvtN9NfIyKWXwFKZBNOfl/5up7Q=;
        b=w1Paxv9LmBXet1GXhGTm65mO4inBwMb49q7MsnmFQqcmWBgcFru9fBxSpNICDfSqEw
         3K5Ym7uDdHv1xSJVJSxqt/kGxUMkjmhI2i8Xow94F3cv7LiGm+NQe70Z2gnsoNen8Otc
         MwwEAmgIC0EHpeDdQ1JZEuE/RwpZmoi/bekDs=
Received: by 10.223.160.144 with SMTP id n16mr945635fax.88.1311838978662;
        Thu, 28 Jul 2011 00:42:58 -0700 (PDT)
Received: from elie (adsl-165-140-99.teol.net [109.165.140.99])
        by mx.google.com with ESMTPS id d6sm314069fak.10.2011.07.28.00.42.55
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 00:42:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311828370-30477-5-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178046>

Dmitry Ivankov wrote:

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1474,8 +1474,11 @@ static void store_tree(struct tree_entry *root)
>  		return;
>  
>  	for (i = 0; i < t->entry_count; i++) {
> -		if (t->entries[i]->tree)
> -			store_tree(t->entries[i]);
> +		if (!S_ISDIR(t->entries[i]->versions[1].mode))
> +			continue;
> +		if (!t->entries[i]->tree)
> +			load_tree(t->entries[i]);
> +		store_tree(t->entries[i]);

How can this load_tree call work if t->entries[i]->versions[1].sha1
is not already in the object database?
