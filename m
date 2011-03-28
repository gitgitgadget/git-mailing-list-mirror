From: tb <tboegi@web.de>
Subject: Re: [PATCH 1/4] vcs-svn: make reading of properties binary-safe
Date: Mon, 28 Mar 2011 17:34:02 +0200
Message-ID: <4D90AA6A.1090904@web.de>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org> <1300970636-31743-1-git-send-email-david.barr@cordelta.com> <20110325033431.GA3007@elie> <20110325040730.GB3007@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, tboegi@web.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:34:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ESX-0002W5-GD
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab1C1PeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:34:19 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47762 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab1C1PeS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:34:18 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 17AE718A86F3C;
	Mon, 28 Mar 2011 17:34:12 +0200 (CEST)
Received: from [194.22.188.61] (helo=[192.168.209.16])
	by smtp01.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #2)
	id 1Q4ESJ-0008CH-00; Mon, 28 Mar 2011 17:34:11 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <20110325040730.GB3007@elie>
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX19IGs4JZmtsmVJLEJSuoJndrIEhiWOIcCHKG/4N
	hxqF/Y6stk2IShxKPAIJzl5Ykd22d8vIsxjFm338uPNq0snG/h
	9fOqEXbSY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170137>

Hej,
I'm not sure if this was the origin email ...

Commit e7d04ee147dcbe6af1fa1d2147466696e is OK.

But:
failure on t9010 with commit 195b7ca6f229455da61f9f6b
=============
#               test_cmp expect.message actual.message &&
#               test_cmp expect.hello1 actual.hello1 &&
#               test_cmp expect.hello2 actual.hello2
#
ok 14 - change file mode and reiterate content
ok 15 - deltas not supported
ok 16 - property deltas supported
ok 17 - properties on /
ok 18 - deltas for typechange
ok 19 - set up svn repo
ok 20 - t9135/svn.dump
# still have 3 known breakage(s)
# failed 1 among remaining 17 test(s)
1..20
=====================

Some more info:
b@birne:~/projects/git/git.git> uname -a
Darwin birne.lan 10.7.0 Darwin Kernel Version 10.7.0: Sat Jan 29 
15:17:16 PST 2011; root:xnu-1504.9.37~1/RELEASE_I386 i386

tb@birne:~/projects/git/git.git> svn --version
svn, version 1.6.15 (r1038135)
    compiled Jan 29 2011, 15:18:15


tb@birne:~/projects/git/git.git> svnadmin --version
svnadmin, version 1.6.15 (r1038135)
    compiled Jan 29 2011, 15:18:15

  which svn
/usr/bin/svn

I can assist with some more testing
BR
/Torsten


On 03/25/2011 05:07 AM, Jonathan Nieder wrote:
 > A caller to buffer_read_string cannot easily tell the difference
 > between the string "foo" followed by an early end of file and the
 > string "foo\0bar\0baz".  In a half-hearted attempt to catch early EOF,
 > c9d1c8ba (2010-12-28) introduced a safety strlen(val) == len for
 > property keys and values, to at least keep svn-fe from reading
 > uninitialized data when a property list ends early due to EOF.
 >
 > But it is permissible for both keys and values to contain null
 > characters, so in handling revision 59151 of the ASF repository svn-fe
 > encounters a null byte and produces the following message:
 >
 >   fatal: invalid dump: unexpected end of file
 >
 > Fix it by using buffer_read_binary to read to a strbuf (and keep track
 > of the actual length read).  Most consumers of properties still use
 > C-style strings, so in practice we still can't use an author or log
 > message with embedded nuls, but at least this way svn-fe won't error
 > out.
 >
 > Reported-by: David Barr<david.barr@cordelta.com>
 > Signed-off-by: Jonathan Nieder<jrnieder@gmail.com>
 > ---
 >   t/t9010-svn-fe.sh |   27 +++++++++++++++++++++++++++
 >   vcs-svn/svndump.c |   24 ++++++++++--------------
 >   2 files changed, 37 insertions(+), 14 deletions(-)
 >
 > diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
 > index 5a6a4b9..47f1e4f 100755
 > --- a/t/t9010-svn-fe.sh
 > +++ b/t/t9010-svn-fe.sh
 > @@ -370,6 +370,33 @@ test_expect_failure 'change file mode but keep 
old content' '
 >   	test_cmp hello actual.target
 >   '
 >
 > +test_expect_success 'null byte in property value' '
 > +	reinit_git&&
 > +	echo "commit message">expect.message&&
 > +	{
 > +		properties \
 > +			unimportant "something with a null byte (Q)" \
 > +			svn:log "commit message"&&
 > +		echo PROPS-END
 > +	} |
 > +	q_to_nul>props&&
 > +	{
 > +		cat<<-\EOF&&
 > +		SVN-fs-dump-format-version: 3
 > +
 > +		Revision-number: 1
 > +		EOF
 > +		echo Prop-content-length: $(wc -c<props)&&
 > +		echo Content-length: $(wc -c<props)&&
 > +		echo&&
 > +		cat props
 > +	}>nullprop.dump&&
 > +	test-svn-fe nullprop.dump>stream&&
 > +	git fast-import<stream&&
 > +	git diff-tree --always -s --format=%s HEAD>actual.message&&
 > +	test_cmp expect.message actual.message
 > +'
 > +
 >   test_expect_success 'change file mode and reiterate content' '
 >   	reinit_git&&
 >   	cat>expect<<-\EOF&&
 > diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
 > index ea5b128..c00f031 100644
 > --- a/vcs-svn/svndump.c
 > +++ b/vcs-svn/svndump.c
 > @@ -147,6 +147,7 @@ static void die_short_read(void)
 >   static void read_props(void)
 >   {
 >   	static struct strbuf key = STRBUF_INIT;
 > +	static struct strbuf val = STRBUF_INIT;
 >   	const char *t;
 >   	/*
 >   	 * NEEDSWORK: to support simple mode changes like
 > @@ -163,15 +164,15 @@ static void read_props(void)
 >   	uint32_t type_set = 0;
 >   	while ((t = buffer_read_line(&input))&&  strcmp(t, "PROPS-END")) {
 >   		uint32_t len;
 > -		const char *val;
 >   		const char type = t[0];
 >   		int ch;
 >
 >   		if (!type || t[1] != ' ')
 >   			die("invalid property line: %s\n", t);
 >   		len = atoi(&t[2]);
 > -		val = buffer_read_string(&input, len);
 > -		if (!val || strlen(val) != len)
 > +		strbuf_reset(&val);
 > +		buffer_read_binary(&input,&val, len);
 > +		if (val.len<  len)
 >   			die_short_read();
 >
 >   		/* Discard trailing newline. */
 > @@ -179,22 +180,17 @@ static void read_props(void)
 >   		if (ch == EOF)
 >   			die_short_read();
 >   		if (ch != '\n')
 > -			die("invalid dump: expected newline after %s", val);
 > +			die("invalid dump: expected newline after %s", val.buf);
 >
 >   		switch (type) {
 >   		case 'K':
 > +			strbuf_swap(&key,&val);
 > +			continue;
 >   		case 'D':
 > -			strbuf_reset(&key);
 > -			if (val)
 > -				strbuf_add(&key, val, len);
 > -			if (type == 'K')
 > -				continue;
 > -			assert(type == 'D');
 > -			val = NULL;
 > -			len = 0;
 > -			/* fall through */
 > +			handle_property(&val, NULL, 0,&type_set);
 > +			continue;
 >   		case 'V':
 > -			handle_property(&key, val, len,&type_set);
 > +			handle_property(&key, val.buf, len,&type_set);
 >   			strbuf_reset(&key);
 >   			continue;
 >   		default:


======================










On 03/25/2011 05:07 AM, Jonathan Nieder wrote:
> A caller to buffer_read_string cannot easily tell the difference
> between the string "foo" followed by an early end of file and the
> string "foo\0bar\0baz".  In a half-hearted attempt to catch early EOF,
> c9d1c8ba (2010-12-28) introduced a safety strlen(val) == len for
> property keys and values, to at least keep svn-fe from reading
> uninitialized data when a property list ends early due to EOF.
>
> But it is permissible for both keys and values to contain null
> characters, so in handling revision 59151 of the ASF repository svn-fe
> encounters a null byte and produces the following message:
>
>   fatal: invalid dump: unexpected end of file
>
> Fix it by using buffer_read_binary to read to a strbuf (and keep track
> of the actual length read).  Most consumers of properties still use
> C-style strings, so in practice we still can't use an author or log
> message with embedded nuls, but at least this way svn-fe won't error
> out.
>
> Reported-by: David Barr<david.barr@cordelta.com>
> Signed-off-by: Jonathan Nieder<jrnieder@gmail.com>
> ---
>   t/t9010-svn-fe.sh |   27 +++++++++++++++++++++++++++
>   vcs-svn/svndump.c |   24 ++++++++++--------------
>   2 files changed, 37 insertions(+), 14 deletions(-)
>
> diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
> index 5a6a4b9..47f1e4f 100755
> --- a/t/t9010-svn-fe.sh
> +++ b/t/t9010-svn-fe.sh
> @@ -370,6 +370,33 @@ test_expect_failure 'change file mode but keep old content' '
>   	test_cmp hello actual.target
>   '
>
> +test_expect_success 'null byte in property value' '
> +	reinit_git&&
> +	echo "commit message">expect.message&&
> +	{
> +		properties \
> +			unimportant "something with a null byte (Q)" \
> +			svn:log "commit message"&&
> +		echo PROPS-END
> +	} |
> +	q_to_nul>props&&
> +	{
> +		cat<<-\EOF&&
> +		SVN-fs-dump-format-version: 3
> +
> +		Revision-number: 1
> +		EOF
> +		echo Prop-content-length: $(wc -c<props)&&
> +		echo Content-length: $(wc -c<props)&&
> +		echo&&
> +		cat props
> +	}>nullprop.dump&&
> +	test-svn-fe nullprop.dump>stream&&
> +	git fast-import<stream&&
> +	git diff-tree --always -s --format=%s HEAD>actual.message&&
> +	test_cmp expect.message actual.message
> +'
> +
>   test_expect_success 'change file mode and reiterate content' '
>   	reinit_git&&
>   	cat>expect<<-\EOF&&
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index ea5b128..c00f031 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -147,6 +147,7 @@ static void die_short_read(void)
>   static void read_props(void)
>   {
>   	static struct strbuf key = STRBUF_INIT;
> +	static struct strbuf val = STRBUF_INIT;
>   	const char *t;
>   	/*
>   	 * NEEDSWORK: to support simple mode changes like
> @@ -163,15 +164,15 @@ static void read_props(void)
>   	uint32_t type_set = 0;
>   	while ((t = buffer_read_line(&input))&&  strcmp(t, "PROPS-END")) {
>   		uint32_t len;
> -		const char *val;
>   		const char type = t[0];
>   		int ch;
>
>   		if (!type || t[1] != ' ')
>   			die("invalid property line: %s\n", t);
>   		len = atoi(&t[2]);
> -		val = buffer_read_string(&input, len);
> -		if (!val || strlen(val) != len)
> +		strbuf_reset(&val);
> +		buffer_read_binary(&input,&val, len);
> +		if (val.len<  len)
>   			die_short_read();
>
>   		/* Discard trailing newline. */
> @@ -179,22 +180,17 @@ static void read_props(void)
>   		if (ch == EOF)
>   			die_short_read();
>   		if (ch != '\n')
> -			die("invalid dump: expected newline after %s", val);
> +			die("invalid dump: expected newline after %s", val.buf);
>
>   		switch (type) {
>   		case 'K':
> +			strbuf_swap(&key,&val);
> +			continue;
>   		case 'D':
> -			strbuf_reset(&key);
> -			if (val)
> -				strbuf_add(&key, val, len);
> -			if (type == 'K')
> -				continue;
> -			assert(type == 'D');
> -			val = NULL;
> -			len = 0;
> -			/* fall through */
> +			handle_property(&val, NULL, 0,&type_set);
> +			continue;
>   		case 'V':
> -			handle_property(&key, val, len,&type_set);
> +			handle_property(&key, val.buf, len,&type_set);
>   			strbuf_reset(&key);
>   			continue;
>   		default:
