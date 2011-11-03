From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error from 'git push' on v1.7.8-rc0
Date: Thu, 03 Nov 2011 12:15:08 -0700
Message-ID: <7vhb2lf26b.fsf@alter.siamese.dyndns.org>
References: <CAJzBP5Q1_zX+H0jeBZNB81KLYAbtJWhUuHA3rf8CuW-_OSFXbg@mail.gmail.com>
 <7vmxcdf2x7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitlist <git@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 20:15:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM2ky-0007kL-6b
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 20:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934432Ab1KCTPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 15:15:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59163 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933862Ab1KCTPL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 15:15:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51A54669F;
	Thu,  3 Nov 2011 15:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k/0c3nj751GM
	mkviG3c43Y/im34=; b=fiSE9uik+4VW9boeAqtZNJ/kqQ4BeovyqztvGXMKBkRi
	M3U9wmean+6ZO2Jk7hWtkwUO+B76/6rRrWyaSer1LYGmaw0ABu1jNqYsBAdTAWAe
	ExHgeAv64BEY9LbESTLd5raPeufpMMKJErkUXNwVghLBMbPVn03NuTMRG8GtWmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FJO2uF
	cVt4PgyIFg/jJTiOnxYWz9pa8tzCAVRhLLVbxQLIDUC9uBO5XfdxGqtrFeVLTxXZ
	TRzI+8pifpTxCxiSU2qAF0nLexyihWhasKG5yhA3Uya7a//M678wkgUNU0GXB/hN
	2fdjBS3qsHD9nvQSHCmnO1sl/60Zt6hxx7BEM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49658669E;
	Thu,  3 Nov 2011 15:15:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0597669D; Thu,  3 Nov 2011
 15:15:09 -0400 (EDT)
In-Reply-To: <7vmxcdf2x7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 Nov 2011 11:59:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25B0EB0A-0650-11E1-9E3D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184740>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan N=C3=A4we <stefan.naewe@gmail.com> writes:
>
>> I get errors from git push when trying to delete a (remote) branch:
>>
>> $ ./bin-wrappers/git versiongit version 1.7.8.rc0
>> $ ./bin-wrappers/git push -q . :refs/heads/nogofatal: bad object
>> 0000000000000000000000000000000000000000fatal: bad object
>> 0000000000000000000000000000000000000000remote: warning: Allowing
>> deletion of corrupt ref.
>
> Thanks. I think the operation does _not_ error out and fail to delete=
, but
> I agree that the "fatal:" message should be squelched.

-- >8 --
Subject: receive-pack: do not expect object 0{40} to exist

When pushing to delete a ref, it uses 0{40} as an object name to signal
that the request is a deletion. We shouldn't trigger "deletion of a
corrupt ref" warning in such a case, which was designed to notice that =
a
ref points at an object that is truly missing from the repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 261b610..7ec68a1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -634,7 +634,7 @@ static int command_singleton_iterator(void *cb_data=
, unsigned char sha1[20])
 	struct command **cmd_list =3D cb_data;
 	struct command *cmd =3D *cmd_list;
=20
-	if (!cmd)
+	if (!cmd || is_null_sha1(cmd->new_sha1))
 		return -1; /* end of list */
 	*cmd_list =3D NULL; /* this returns only one */
 	hashcpy(sha1, cmd->new_sha1);
@@ -659,11 +659,16 @@ static int iterate_receive_command_list(void *cb_=
data, unsigned char sha1[20])
 	struct command **cmd_list =3D cb_data;
 	struct command *cmd =3D *cmd_list;
=20
-	if (!cmd)
-		return -1; /* end of list */
-	*cmd_list =3D cmd->next;
-	hashcpy(sha1, cmd->new_sha1);
-	return 0;
+	while (cmd) {
+		if (!is_null_sha1(cmd->new_sha1)) {
+			hashcpy(sha1, cmd->new_sha1);
+			*cmd_list =3D cmd->next;
+			return 0;
+		}
+		cmd =3D cmd->next;
+	}
+	*cmd_list =3D NULL;
+	return -1; /* end of list */
 }
=20
 static void execute_commands(struct command *commands, const char *unp=
acker_error)
