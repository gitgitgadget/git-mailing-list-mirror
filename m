From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [JGIT PATCH 2/3] Cleanup of Branch command ready for verbose
 mode
Date: Mon, 18 Aug 2008 15:41:55 +0200
Message-ID: <48A97C23.8030103@gmail.com>
References: <1219057305-9284-1-git-send-email-charleso@charleso.org> <1219057305-9284-2-git-send-email-charleso@charleso.org> <1219057305-9284-3-git-send-email-charleso@charleso.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles O'Farrell <charleso@charleso.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 15:43:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV50o-0000Y0-9Q
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 15:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbYHRNmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 09:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbYHRNmE
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 09:42:04 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:16027 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbYHRNmC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 09:42:02 -0400
Received: by mu-out-0910.google.com with SMTP id w8so3372273mue.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nWl8Y5/woaLizxh5AWwXvgF9bXc4vbR4XsbPe+Bb/vE=;
        b=ErutK5TWO1bsFLmQTAtyh3oP3+HVBTzUQ+IOoz1umURogoUgHV1u5wTDa7Ffnw7cka
         if8kz1Now4sQH4T0TcPtkZhZa+yMsqRJDZEZt+feVeMiuTLLUhi9+rxYTwKduhZhH0k9
         cx1oZVQkKW1Z3lEcDkRMsF0tVMfVAmyuCyWxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=IlIkBckq0czgjASsjWyF2tLujMJsGC4zv9PDEdzmezsERaj80YddkMKDDVhAEf0ecq
         rVUjKr/0SBjnULSQwl2JBVqkSiiiT1UY5BKlapRVukdBdyy13aGuvYDvbNu2SZs1N/R0
         wsZJWPcm1ZlQuxOTNs0Wu5HTnwfeQoDp93Ojg=
Received: by 10.102.228.2 with SMTP id a2mr3953940muh.79.1219066920313;
        Mon, 18 Aug 2008 06:42:00 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id y6sm503345mug.7.2008.08.18.06.41.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 06:41:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <1219057305-9284-3-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92707>

Charles O'Farrell wrote:
> diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
(...)
> @@ -87,17 +91,27 @@ private void list() {
>  		if (head != null) {
>  			String current = head.getName();
>  			if (current.equals(Constants.HEAD))
> -				printHead("(no branch)", true);
> -			for (String ref : new TreeSet<String>(refs.keySet())) {
> -				if (isHead(ref))
> -					printHead(ref, current.equals(ref));
> +				addRef("(no branch)", head);
> +			addRefs(refs, Constants.HEADS_PREFIX, !remote);
> +			addRefs(refs, Constants.REMOTES_PREFIX, remote);

We used to use (Constants.HEADS_PREFIX + '/') or 
(Constants.REMOTES_PREFIX + '/') in such places, probably to handle 
correctly jokes like refs named "refs/remotes_will_broke_your_code".

I've seen this expression so many times that I think it's right moment 
to create another Constants.HEADS_PREFIX_SLASHED (same for tags, 
remotes) or similar as this piece of this code is redundant in many 
places. But wait, does anybody use pure ones without slashes? Maybe we 
can just change existing constants.

Beside of that detail, me (being just jgit developer) says that the 
series looks good. Oh, and it's probably good to follow convention of 
marking variables as final when they are final.

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
