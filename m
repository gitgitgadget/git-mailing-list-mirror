From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] index-pack: rationalize unpack_entry_data()
Date: Mon, 12 Apr 2010 08:36:25 +0200
Message-ID: <4BC2BF69.8050100@viscovery.net>
References: <1271041047-32563-1-git-send-email-nico@fluxnic.net> <1271041047-32563-2-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Apr 12 08:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1DG5-00073j-KR
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 08:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0DLGg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 02:36:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:23993 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab0DLGg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 02:36:27 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O1DFy-0001mr-Nc; Mon, 12 Apr 2010 08:36:26 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 77AC61660F;
	Mon, 12 Apr 2010 08:36:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1271041047-32563-2-git-send-email-nico@fluxnic.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144705>

Am 4/12/2010 4:57, schrieb Nicolas Pitre:
> -	for (;;) {
> -		int ret = git_inflate(&stream, 0);
> -		use(input_len - stream.avail_in);
> -		if (stream.total_out == size && ret == Z_STREAM_END)
> -			break;
> -		if (ret != Z_OK)
> -			bad_object(offset, "inflate returned %d", ret);
> +	do {
>  		stream.next_in = fill(1);
>  		stream.avail_in = input_len;
> -	}
> +		status = git_inflate(&stream, 0);
> +		use(input_len - stream.avail_in);
> +	} while (status == Z_OK);
>  	git_inflate_end(&stream);
> +	if (stream.total_out != size || status != Z_STREAM_END)
> +		bad_object(offset, "inflate returned %d", status);
>  	return buf;

Is stream.total_out still valid after inflateEnd() (and I mean "valid by
definition", not just "by accident")? To stay on the safe side, you should
call git_inflate_end only after this last check.

-- Hannes
