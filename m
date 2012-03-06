From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH] fix deletion of .git/objects sub-directories
 in git-prune/repack
Date: Tue, 06 Mar 2012 13:57:43 -0800
Message-ID: <7vipihqtns.fsf@alter.siamese.dyndns.org>
References: <OFBC9E02C9.526DB40C-ONC12579B9.00726ECA-C12579B9.00763181@dcon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Stefan Naewe <stefan.naewe@gmail.com>
To: karsten.blees@dcon.de
X-From: git-owner@vger.kernel.org Tue Mar 06 22:57:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S52OG-0001uf-JL
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086Ab2CFV5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:57:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932377Ab2CFV5q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:57:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA89554ED;
	Tue,  6 Mar 2012 16:57:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rGB1mTWcEpxSicwAQTIZ/NPQO70=; b=fVkdIC
	iVM9dtXNeDUVUMccFC/DJU3ZpZyYDg8zVDme80lBgmL/UWrVZazApc39tcbyoMZK
	4AZ0UK9jh/jcqSzDA3eIfZ5z2RwliHnY9mImwPc1htFp/oRHaz9R7CiLFqDbR4HV
	FsWLDiZcFDItREGuobh/kE++gZfSfdQPCCQBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bdLzORldo2CahfsqM/BAMXF6Voas4UUY
	cI7D94FSoyhxvPGOrxHMOAOorZZLwHQQC/GGVhZTyAZ6a+k+bFvgmpPaeKEAkryE
	4AAZnOKaIxv0F5Qi88Qyv1aNN8ok5d02mV2by3oLyr5nKFGRv940JNw1436/qZph
	gVKJOH3eY+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0F0054EC;
	Tue,  6 Mar 2012 16:57:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B54054EB; Tue,  6 Mar 2012
 16:57:45 -0500 (EST)
In-Reply-To: <OFBC9E02C9.526DB40C-ONC12579B9.00726ECA-C12579B9.00763181@dcon.de> (karsten
 blees's message of "Tue, 6 Mar 2012 22:30:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67B67266-67D7-11E1-94A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192403>

karsten.blees@dcon.de writes:

> OT: While looking at the code I just stumbled across this immediately
> above the patch (prune-packed.c line 32ff):
>
>                 memcpy(pathname + len, de->d_name, 38);
>                 if (opts & DRY_RUN)
>                         printf("rm -f %s\n", pathname);
>                 else
>                         unlink_or_warn(pathname);
>
> Shouldn't this be memcpy(..., 39) (i.e. including '\0')?

I think the only thing that is guaranteeing that pathname[len+38] is
NUL is that we do not hop around repositories, so once we fill the
static char pathname[PATH_MAX] in prune_packed_objects(), nobody
writes to that location, because the length of the leading part
(i.e. "len" given to prune_dir()) will stay constant during the
lifetime of the process.

So it is not currently a problem, but it would be better to clear
that byte here.

Good eyes.
