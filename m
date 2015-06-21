From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 03/19] fsck: Provide a function to parse fsck message
 IDs
Date: Sun, 21 Jun 2015 15:46:42 +0200
Organization: gmx
Message-ID: <de90ffde976a5fdcc580472387ca20ae@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <8129a20ee6befc74eb45b6225edaaa1b61647d08.1434720655.git.johannes.schindelin@gmx.de>
 <xmqq4mm38qbk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 15:46:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6faL-0003aS-N3
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 15:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbbFUNqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 09:46:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:54675 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbbFUNqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 09:46:52 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M0yaB-1YphpT0isB-00v7xS; Sun, 21 Jun 2015 15:46:44
 +0200
In-Reply-To: <xmqq4mm38qbk.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:5H6dGNJ2rkqKTy4HvFQljVnn+imZIlUPsTbCh/EzWe3DE30ANqd
 cD05Hj2hLuQZl/fC+y0V+bH8RbvXLfTkVIIXUkGPo8lN6plJPP0+4/sfQ2351yCQ38wpEh1
 QRtEf9SEImwjz/L3sVwwvHST5MdqUnidVpYWebodM39LM/8Kx0jc6lsn9jk+O2Ujf4qwJyA
 bBzv4fXjTZkIYTa2wuXHw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272263>

Hi Junio,

On 2015-06-19 21:13, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> +#define MSG_ID(id, msg_type) { STR(id), FSCK_##msg_type },
>>  static struct {
>> +	const char *id_string;
>>  	int msg_type;
>>  } msg_id_info[FSCK_MSG_MAX + 1] = {
>>  	FOREACH_MSG_ID(MSG_ID)
>> -	{ -1 }
>> +	{ NULL, -1 }
>>  };
>>  #undef MSG_ID
>>
>> +static int parse_msg_id(const char *text, int len)
>> +{
>> +	int i, j;
>> +
>> +	if (len < 0)
>> +		len = strlen(text);
>> +
>> +	for (i = 0; i < FSCK_MSG_MAX; i++) {
> 
> I wonder an array without sentinel at the end with ARRAY_SIZE() may
> be a leaner way to do these, especially as this is all limited to
> this single file.

The real reason is that I cannot prevent a trailing comma with the way I construct the array, so FSCK_MSG_MAX is a natural way to support compilers that do not allow something like

    enum { A, B, C, };

>> +		const char *key = msg_id_info[i].id_string;
>> +		/* match id_string case-insensitively, without underscores. */
>> +		for (j = 0; j < len; j++) {
>> +			char c = *(key++);
>> +			if (c == '_')
>> +				c = *(key++);
> 
> s/if/while/ perhaps?

Actually, I want to prevent double underscores so that no ambiguity occurs between the camelCased version of, say, JUNIO_HAMANO and JUNIO__HAMANO.

I inserted an `assert()`;

>> +			if (toupper(text[j]) != c)
> 
> I know the performance would not matter very much but calling
> toupper() for each letter in the user input FSCK_MSG_MAX times
> sounds rather inefficient.
> 
> Would it make sense to make the caller upcase instead (or upcase
> upfront in the function)?

As you said, performance plays a lesser role here than simplicity. The strings we receive here are passed in read-only, therefore I would have to `strdup()` them first and then make sure to `free()` them. That was too un-simple for my taste.

Having said that, if you disagree, I will introduce the complexity, though. Do you want me to do that?

Ciao,
Dscho
