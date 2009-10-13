From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH v2 01/16] pkt-line: Add strbuf based functions
Date: Tue, 13 Oct 2009 09:29:22 +0200
Message-ID: <4AD42C52.80205@viscovery.net>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:39:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxbw5-00016f-Ri
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933671AbZJMHaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 03:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933630AbZJMHaA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:30:00 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44004 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933616AbZJMHaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 03:30:00 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mxbow-0000Ff-VX; Tue, 13 Oct 2009 09:29:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B09759614; Tue, 13 Oct 2009 09:29:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1255400715-10508-2-git-send-email-spearce@spearce.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130140>

Shawn O. Pearce schrieb:
> -int packet_read_line(int fd, char *buffer, unsigned size)
> +static int packet_length(unsigned *ret_len, const char *linelen)
>  {
>  	int n;
> -	unsigned len;
> -	char linelen[4];
> -
> -	safe_read(fd, linelen, 4);
> +	unsigned len = 0;
>  
> -	len = 0;
>  	for (n = 0; n < 4; n++) {
>  		unsigned char c = linelen[n];
>  		len <<= 4;
> @@ -96,8 +116,20 @@ int packet_read_line(int fd, char *buffer, unsigned size)
>  			len += c - 'A' + 10;
>  			continue;
>  		}
> -		die("protocol error: bad line length character");
> +		return -1;
>  	}
> +	*ret_len = len;
> +	return 0;
> +}

len can be signed: Valid lengths fit into a signed int. Then you can
'return len;' on success and 'return -1;' on failure and don't need return
the result by reference. packet_read_line() ultimately converts it to int
anyway:

> +int packet_read_line(int fd, char *buffer, unsigned size)
> +{
> +	unsigned len;
> +	char linelen[4];
> +
> +	safe_read(fd, linelen, 4);
> +	if (packet_length(&len, linelen))
> +		die("protocol error: bad line length character");
>  	if (!len)
>  		return 0;
>  	len -= 4;
> @@ -107,3 +139,28 @@ int packet_read_line(int fd, char *buffer, unsigned size)
>  	buffer[len] = 0;
>  	return len;
>  }

-- Hannes
