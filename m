From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Fri, 23 Mar 2012 10:47:48 -0700
Message-ID: <7v62dvus3f.fsf@alter.siamese.dyndns.org>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <7vmx79zeui.fsf@alter.siamese.dyndns.org>
 <CAJsNXT=YEida53nV7kj6a3cw2GibYJab4n2PucNO6inUR3HPRQ@mail.gmail.com>
 <7v8viswdho.fsf@alter.siamese.dyndns.org> <87pqc3ei08.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PJ Weisberg <pj@irregularexpressions.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:48:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB8ai-00046A-4U
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155Ab2CWRrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:47:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611Ab2CWRru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 13:47:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 247EC6D8F;
	Fri, 23 Mar 2012 13:47:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k33JiJ/azFTsMOTfSUQAwdfMOVM=; b=Lwg+ZJ
	drmjn57AlVPQf9R0MuU1J/zJ900mlpQlRWPh3X74wGnTzrjGhQwKRjaJzkt4DRZ/
	g4HeXr9p1dvqqtB8Yl7axvbLPz2Glzdy2DlgsFfihpxCeG63Oh6rIe5chlpmDKU4
	/eD1tKjLP3J0gnOm5rWItkZ/gX8OftVsOtIjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jBfrUz4x5TclfMan4JyoccqWTX0G4NMf
	IlWxpfNsAbOiDMRdIeFlMNG1z+Y8XJJznXd/ub3BET6iLv9X+gOoSR55wAL7XbnW
	P73+5mHVH8AJkXWaTapkjkRL7kat5TYj5w5RfZTD+7DzeFDpG5gGhnMJDhaRxrTc
	RFXEzGRLnlk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1967E6D8B;
	Fri, 23 Mar 2012 13:47:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A20206D89; Fri, 23 Mar 2012
 13:47:49 -0400 (EDT)
In-Reply-To: <87pqc3ei08.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 23 Mar 2012 11:20:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E9E3994-7510-11E1-BADA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193781>

Thomas Rast <trast@student.ethz.ch> writes:

> How about trying to read "HEAD" as "head" instead when core.ignorecase
> is true?  That would allow us to catch such misconfiguration (which I
> imagine can also happen accidentally if you mv a repository across FS
> boundaries) and tell the user about it.

Do you mean something like this?

I do not like it.  It essentially amounts to checking with the FS every
time we run Git.

 config.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.c b/config.c
index 68d3294..8783937 100644
--- a/config.c
+++ b/config.c
@@ -575,7 +575,16 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.ignorecase")) {
+		static int true_case; /* 0: unknown, 1: sensitive, 2: fat */
 		ignore_case = git_config_bool(var, value);
+		if (ignore_case) {
+			if (!true_case) {
+				true_case = fs_is_case_sensitive() ? 1 : 2;
+				if (true_case == 2)
+					warn("Whoa");
+			}
+			ignore_case = true_case >> 1;
+		}
 		return 0;
 	}
 
