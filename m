Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.4 required=3.0 tests=AWL,BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MIME_CHARSET_FARAWAY,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06F61FAA8
	for <e@80x24.org>; Tue, 16 May 2017 13:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdEPN4u (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 09:56:50 -0400
Received: from m12-11.163.com ([220.181.12.11]:36454 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751080AbdEPN4s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 09:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=iM+cv
        BIyW/Jy/FPu5oBW+9IwvRA3uQoIVg+SLK+P3Ig=; b=WKHUOpspl+XarpuyVoOTK
        m0+5QAqSJ2BGRhvdAW95A8jYbpxB8KsFUDbQJsbI99fgyX/7v+wfoZv/3+TY98PS
        wluqTEi7ClSJoUAS4TxcvbjSgjzhHO91yODPtTlLbT9M5d7PPAZato2NZYppVJnD
        VNSGzDmDbT+W70Iut1PQz8=
Received: from [192.168.0.108] (unknown [219.143.190.219])
        by smtp7 (Coremail) with SMTP id C8CowACHlhLHBBtZsIHrFQ--.61907S2;
        Tue, 16 May 2017 21:55:19 +0800 (CST)
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] send-email: --batch-size to work around some SMTP server limit
From:   =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
X-Mailer: iPhone Mail (14E304)
In-Reply-To: <20170516141014.6e8487df.viktorin@rehivetech.com>
Date:   Tue, 16 May 2017 21:55:18 +0800
Cc:     git@vger.kernel.org, gitster@pobox.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2BB8B551-01A6-4470-9370-5B1A03EB96D0@163.com>
References: <20170513015726.20281-1-zxq_yx_007@163.com> <20170516141014.6e8487df.viktorin@rehivetech.com>
To:     Jan Viktorin <viktorin@rehivetech.com>
X-CM-TRANSID: C8CowACHlhLHBBtZsIHrFQ--.61907S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw45uw15KFWftFW7Cw1DGFg_yoWrCw18pr
        yDWFWYgFy8tF1Yya1Iyw1xWryYgrZ5trnFgw1rKr1UAa45AF9Iyr1UtrWrZFWfJr1qgrWa
        vr1jgF93uF4qyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_eOdUUUUU=
X-Originating-IP: [219.143.190.219]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiqBDZxlc686D4OwABsb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> =D4=DA 2017=C4=EA5=D4=C216=C8=D5=A3=AC20:10=A3=ACJan Viktorin <viktorin@re=
hivetech.com> =D0=B4=B5=C0=A3=BA
>=20
> Hello,
>=20
> with this patch applied to git 2.12, I could see:
>=20
> Use of uninitialized value $batch_size in numeric eq (=3D=3D) at /usr/lib/=
git-core/git-send-email line 1679
>=20
> when --batch-size is NOT used. See below...
>=20
> On Sat, 13 May 2017 09:57:26 +0800
> xiaoqiang zhao <zxq_yx_007@163.com> wrote:
>=20
>> Some email servers (e.g. smtp.163.com) limit the number emails to be
>> sent per session(connection) and this will lead to a faliure when
>> sending many messages.
>>=20
>> Teach send-email to disconnect after sending a number of messages
>> (configurable via the --batch-size=3D<num> option), wait for a few
>> seconds (configurable via the --relogin-delay=3D<seconds> option) and
>> reconnect, to work around such a limit.
>>=20
>> Also add this two configure option for git config command.
>>=20
>> Note:
>>   Re-authentication will happen every $<batch-size> messages, so it
>> will be much more acceptable if you use some form of credential helper
>> (e.g. the 'sendemail.smtppass' config option), otherwise you will have
>> to retype password every time when asked.
>>=20
>> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
>> ---
>> contrib/completion/git-completion.bash |  2 ++
>> git-send-email.perl                    | 18 ++++++++++++++++++
>> 2 files changed, 20 insertions(+)
>>=20
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
>> index af658995d..29496353a 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2608,6 +2608,8 @@ _git_config ()
>>        sendemail.thread
>>        sendemail.to
>>        sendemail.validate
>> +        sendemail.smtpbatchsize
>> +        sendemail.smtprelogindelay
>>        showbranch.default
>>        status.relativePaths
>>        status.showUntrackedFiles
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index eea0a517f..071d1ab9d 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -81,6 +81,10 @@ git send-email --dump-aliases
>>                                      This setting forces to use one of th=
e listed mechanisms.
>>     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
>>=20
>> +    --batch-size            <int>  * send max <int> message per connecti=
on.
>> +    --relogin-delay         <int>  * delay <int> seconds between two suc=
cessive login, default to 1,
>> +                                     This option can only be used with -=
-batch-size
>> +
>>   Automating:
>>     --identity              <str>  * Use the sendemail.<id> options.
>>     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
>> @@ -153,6 +157,7 @@ my $have_email_valid =3D eval { require Email::Valid;=
 1 };
>> my $have_mail_address =3D eval { require Mail::Address; 1 };
>> my $smtp;
>> my $auth;
>> +my $num_sent =3D 0;
>>=20
>> # Regexes for RFC 2047 productions.
>> my $re_token =3D qr/[^][()<>@,;:\\"\/?.=3D \000-\037\177-\377]+/;
>> @@ -216,6 +221,7 @@ my ($cover_cc, $cover_to);
>> my ($to_cmd, $cc_cmd);
>> my ($smtp_server, $smtp_server_port, @smtp_server_options);
>> my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
>> +my ($batch_size, $relogin_delay);
>> my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
>> my ($validate, $confirm);
>> my (@suppress_cc);
>> @@ -247,6 +253,8 @@ my %config_settings =3D (
>>     "smtppass" =3D> \$smtp_authpass,
>>     "smtpdomain" =3D> \$smtp_domain,
>>     "smtpauth" =3D> \$smtp_auth,
>> +    "smtpbatchsize" =3D> \$batch_size,
>> +    "smtprelogindelay" =3D> \$relogin_delay,
>>     "to" =3D> \@initial_to,
>>     "tocmd" =3D> \$to_cmd,
>>     "cc" =3D> \@initial_cc,
>> @@ -358,6 +366,8 @@ $rc =3D GetOptions(
>>            "force" =3D> \$force,
>>            "xmailer!" =3D> \$use_xmailer,
>>            "no-xmailer" =3D> sub {$use_xmailer =3D 0},
>> +            "batch-size=3Di" =3D> \$batch_size,
>> +            "relogin-delay=3Di" =3D> \$relogin_delay,
>>     );
>>=20
>> usage() if $help;
>> @@ -1664,6 +1674,14 @@ foreach my $t (@files) {
>>        }
>>    }
>>    $message_id =3D undef;
>> +    $num_sent++;
>> +    if ($num_sent =3D=3D $batch_size) {
>=20
> This is the line. I think, batch_size can be sometimes uninitialized
> while this statement is executed.
>=20
> Regards
> Jan

Thank you for reporting this=A3=ACI will take a look .
>=20
>> +        $num_sent =3D 0;
>> +        $smtp->quit if defined $smtp;
>> +        undef $smtp;
>> +        undef $auth;
>> +        sleep($relogin_delay);
>> +    }
>> }
>>=20
>> # Execute a command (e.g. $to_cmd) to get a list of email addresses


