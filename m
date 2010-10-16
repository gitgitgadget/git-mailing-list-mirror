From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] send-pack: avoid redundant "pack-objects died with strange error"
Date: Sat, 16 Oct 2010 11:25:33 +0200
Message-ID: <201010161125.33372.j6t@kdbg.org>
References: <20101009201751.GK9348@bzzt.net> <20101012201946.GA15080@burratino> <20101016060423.GA26538@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Arnout Engelen <arnouten@bzzt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 11:29:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P734b-0000p4-Gl
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 11:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab0JPJZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 05:25:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:61482 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174Ab0JPJZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 05:25:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D6B022C4009;
	Sat, 16 Oct 2010 11:25:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9136E19F5E9;
	Sat, 16 Oct 2010 11:25:33 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20101016060423.GA26538@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159157>

On Samstag, 16. Oktober 2010, Jonathan Nieder wrote:
> Saying "pack-objects died with strange error" after "pack-objects
> died of signal 13" seems kind of redundant.  The latter was
> introduced when send-pack switched to the run-command API, which
> reports abnormal exits on behalf of the caller.
>
> Normal exits with nonzero status are not reported by run-command,
> though.

The rationale for this is the assumption that before a program or script exits 
with non-zero status, it will have reported an error.

> Or in the "controlled exit" case:
>
> 	[...]
> 	error: pack-objects died with status 128
> 	error: failed to push some refs to 'ssh://example.com/foo/bar'

I sense that this quote is not complete. Did you strip some error message by 
writing just "[...]"?

> -	if (finish_command(&po))
> -		return error("pack-objects died with strange error");
> -	return 0;
> +	status = finish_command(&po);
> +	if (status > 0)
> +		return error("pack-objects died with status %d", status);
> +	return status;

Ideally, this should really just be

	if (finish_command(&po))
		return -1;

-- Hannes
