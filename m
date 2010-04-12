From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] index-pack: smarter memory usage when resolving deltas
Date: Mon, 12 Apr 2010 08:30:33 +0200
Message-ID: <4BC2BE09.7060809@viscovery.net>
References: <1271041047-32563-1-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Apr 12 08:30:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1DAV-0005Fu-Qx
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 08:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab0DLGal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 02:30:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18481 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab0DLGal (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 02:30:41 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O1DAJ-0001YF-W9; Mon, 12 Apr 2010 08:30:36 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8A8E01660F;
	Mon, 12 Apr 2010 08:30:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1271041047-32563-1-git-send-email-nico@fluxnic.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144704>

Am 4/12/2010 4:57, schrieb Nicolas Pitre:
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -359,34 +359,33 @@ static void *get_data_from_pack(struct object_entry *obj)
>  {
>  	off_t from = obj[0].idx.offset + obj[0].hdr_size;
>  	unsigned long len = obj[1].idx.offset - from;
> -	unsigned long rdy = 0;
> -	unsigned char *src, *data;
> +	unsigned char *data, inbuf[4096];

With this tiny buffer we make way more pread() calls than we used to,
right? This hurts emulated pread(), where we do at least 4 syscalls per
pread(). Shouldn't the buffer be much larger, like min(len,16*4096)?

-- Hannes
