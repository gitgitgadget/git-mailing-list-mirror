From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Work around EMFILE when there are too many pack files
Date: Tue, 02 Nov 2010 09:44:58 +0100
Message-ID: <4CCFCF8A.20608@viscovery.net>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org> <1288652061-19614-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 02 09:45:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDCUT-00027b-Jm
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 09:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab0KBIpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 04:45:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41697 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0KBIpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 04:45:06 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PDCUK-0005px-8h; Tue, 02 Nov 2010 09:45:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 052111660F;
	Tue,  2 Nov 2010 09:45:03 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <1288652061-19614-3-git-send-email-spearce@spearce.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160510>

Am 11/1/2010 23:54, schrieb Shawn O. Pearce:
> -static int git_open_noatime(const char *name)
> +static int git_open_noatime(const char *name, struct packed_git *p)
>  {
>  	static int sha1_file_open_flag = O_NOATIME;
> -	int fd = open(name, O_RDONLY | sha1_file_open_flag);
>  
> -	/* Might the failure be due to O_NOATIME? */
> -	if (fd < 0 && errno != ENOENT && sha1_file_open_flag) {
> -		fd = open(name, O_RDONLY);
> +	for (;;) {
> +		int fd = open(name, O_RDONLY | sha1_file_open_flag);
>  		if (fd >= 0)
> +			return fd;
> +
> +		/* Might the failure be insufficient file descriptors? */
> +		if (errno == EMFILE) {
> +			if (unuse_one_window(p, -1))
> +				continue;
> +			else
> +				return -1;
> +		}
> +
> +		/* Might the failure be due to O_NOATIME? */
> +		if (errno != ENOENT && sha1_file_open_flag) {
>  			sha1_file_open_flag = 0;
> +			continue;
> +		}
> +
> +		return -1;
>  	}
> -	return fd;
>  }

Oh, boy! A function that returns a value, but does not have a return
statement at the end? Even a goto would be easier to read:

retry:
	fd = open(name, O_RDONLY | sha1_file_open_flag);
	if (fd >= 0)
		return fd;

	if (errno == EMFILE) {
		if (unuse_one_window(p, -1))
			goto retry;
		return -1;
	}

	if (errno != ENOENT && sha1_file_open_flag) {
		sha1_file_open_flag = 0;
		goto retry;
	}

	return -1;

IMHO, of course.

-- Hannes
