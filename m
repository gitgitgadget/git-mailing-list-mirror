From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] push: heed user.signingkey for signed pushes
Date: Fri, 24 Oct 2014 17:03:40 +0200
Message-ID: <544A6A4C.4070704@drmicha.warpmail.net>
References: <787502533676138ad113e446eba71d92dee3b4de.1413989046.git.git@drmicha.warpmail.net>	<7b3546cd125d1ad92dd62297ecbe624a78c6079b.1413989799.git.git@drmicha.warpmail.net> <xmqq7fzru5do.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 17:03:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhgP7-0002R4-FV
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 17:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbaJXPDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 11:03:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60759 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755768AbaJXPDm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2014 11:03:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id ADB0F2082C
	for <git@vger.kernel.org>; Fri, 24 Oct 2014 11:03:41 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 24 Oct 2014 11:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Uv3wIDrFiZpQRj4rRCuYXm
	ur2B8=; b=UlsEZ7/ntgBuRaUhzaD0fYg8GGVaq2RGUMCVeAZwRUiut0eO6oTR/T
	yWujvE9qrIBHU4l/SyDK2IOJW0sItBoGdJFKb+9uzJSbJcALd47FPIuy5hC0wUrh
	TXKdQuyEKRxESfDa6uJ4U3B4CZ5kh82rOrFxV0s5uuZB2Tvctcsf4=
X-Sasl-enc: FzejG6D4Jm5Kx5DJRES/fFtxKvbDD6BEOgla9KahQCYg 1414163021
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1635B68018B;
	Fri, 24 Oct 2014 11:03:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq7fzru5do.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano schrieb am 23.10.2014 um 00:05:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> push --signed promises to take user.signingkey as the signing key but
>> fails to read the config.
>>
>> Make it do so.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Okay, I guess this is nicer. We do have the committer info in the env. Sorry.
>>
>>  builtin/push.c         |  13 ++++++++++++-
>>  t/lib-gpg/trustdb.gpg  | Bin 1360 -> 1360 bytes
>>  t/t5534-push-signed.sh |  44 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 56 insertions(+), 1 deletion(-)
> 
> Hmph, I simply forgot about that configuration, I guess.

It's easy to overlook: user.email is picked up by git_default_config,
but user.signingkey is not. In hindsight, gpg.signingkey might have been
a good choice, too.

> What is this change to trustdb about, though?  The log message does
> not say anything about it.

Ooops, I'm sorry. That must have sneaked in from running gpg with that
home to see which keys we have in the test env. No change in trustdb
intended. Probably gpg did some automatic trustdb recalculations, even
though all I did was gpg --list-key.

>>
>> diff --git a/builtin/push.c b/builtin/push.c
>> index ae56f73..a076b19 100644
>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -471,6 +471,17 @@ static int option_parse_recurse_submodules(const struct option *opt,
>>  	return 0;
>>  }
>>  
>> +static int git_push_config(const char *k, const char *v, void *cb)
>> +{
>> +	struct wt_status *s = cb;
>> +	int status;
>> +
>> +	status = git_gpg_config(k, v, NULL);
>> +	if (status)
>> +		return status;
>> +	return git_default_config(k, v, s);
>> +}
>> +
>>  int cmd_push(int argc, const char **argv, const char *prefix)
>>  {
>>  	int flags = 0;
>> @@ -511,7 +522,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>  	};
>>  
>>  	packet_trace_identity("push");
>> -	git_config(git_default_config, NULL);
>> +	git_config(git_push_config, NULL);
>>  	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
>>  
>>  	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
>> diff --git a/t/lib-gpg/trustdb.gpg b/t/lib-gpg/trustdb.gpg
>> index 4879ae9a84650a93a4d15bd6560c5d1b89eb4c2f..c11b1464b3d13b45966a493e2174fc0e253ddd0c 100644
>> GIT binary patch
>> delta 47
>> ncmcb>b%9HOF})z2nVFH5k%@sJ#C^}~iH71E)x}wb7%%_;=xPS!
>>
>> delta 51
>> tcmcb>b%9HSF})z2nVFH5k%@sJ&}Z5*1_lPkiGso#)x}wb*nk{V008$D2C@JE
>>
>> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
>> index 2786346..ecb8d44 100755
>> --- a/t/t5534-push-signed.sh
>> +++ b/t/t5534-push-signed.sh
>> @@ -124,4 +124,48 @@ test_expect_success GPG 'signed push sends push certificate' '
>>  	test_cmp expect dst/push-cert-status
>>  '
>>  
>> +test_expect_success GPG 'fail without key and heed user.signingkey' '
>> +	prepare_dst &&
>> +	mkdir -p dst/.git/hooks &&
>> +	git -C dst config receive.certnonceseed sekrit &&
>> +	write_script dst/.git/hooks/post-receive <<-\EOF &&
>> +	# discard the update list
>> +	cat >/dev/null
>> +	# record the push certificate
>> +	if test -n "${GIT_PUSH_CERT-}"
>> +	then
>> +		git cat-file blob $GIT_PUSH_CERT >../push-cert
>> +	fi &&
>> +
>> +	cat >../push-cert-status <<E_O_F
>> +	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
>> +	KEY=${GIT_PUSH_CERT_KEY-nokey}
>> +	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
>> +	NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
>> +	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
>> +	E_O_F
>> +
>> +	EOF
>> +
>> +	unset GIT_COMMITTER_EMAIL &&
>> +	git config user.email hasnokey@nowhere.com &&
>> +	test_must_fail git push --signed dst noop ff +noff &&
>> +	git config user.signingkey committer@example.com &&
>> +	git push --signed dst noop ff +noff &&
>> +
>> +	(
>> +		cat <<-\EOF &&
>> +		SIGNER=C O Mitter <committer@example.com>
>> +		KEY=13B6F51ECDDE430D
>> +		STATUS=G
>> +		NONCE_STATUS=OK
>> +		EOF
>> +		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
>> +	) >expect &&
>> +
>> +	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
>> +	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
>> +	test_cmp expect dst/push-cert-status
>> +'
>> +
>>  test_done
