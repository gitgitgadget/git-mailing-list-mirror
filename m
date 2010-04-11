From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH 2/3] add a library of code for producing structured output
Date: Sun, 11 Apr 2010 20:21:10 +0100
Message-ID: <91d4c9c4ecdd32166bedb6dc0bd007d6@212.159.54.234>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> <20100411113733.80010.3767.julian@quantumfyre.co.uk> <7vy6gtonwt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>, Eric Raymond <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 21:21:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O12id-0003a4-Qf
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 21:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab0DKTVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 15:21:13 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:41177 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751957Ab0DKTVM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 15:21:12 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 7DF05819C6D7;
	Sun, 11 Apr 2010 20:21:05 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 3E63120CF4E;
	Sun, 11 Apr 2010 20:21:11 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ff71SC48V5aU; Sun, 11 Apr 2010 20:21:10 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id D4A52C8153;
	Sun, 11 Apr 2010 20:21:10 +0100 (BST)
In-Reply-To: <7vy6gtonwt.fsf@alter.siamese.dyndns.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144678>

On Sun, 11 Apr 2010 11:16:18 -0700, Junio C Hamano <gitster@pobox.com>
wrote:
> Julian Phillips <julian@quantumfyre.co.uk> writes:
> 
>> Add a library that allows commands to produce structured output in any
>> of a range of formats using a single API.
>>
>> The API includes an OPT_OUTPUT and handle_output_arg so that the
>> option handling for different commands will be as similar as possible.
> 
> I was hoping that the existing low-level -z routines (e.g. "diff-* -z")
> follow similar enough patterns to have a corresponding output-z.c and be
> handled inside output.c library.  But that is not a requirement, just
> "would have been nicer if the original were written that way".

As the API currently stands, I don't think it would be possible to
recreate the existing output of -z, as the separator between values is not
constant.  I haven't really looked into whether the output is completely
incompatible with structured output though (i.e. could -z be supported by
adding one or two functions to the API?).

>> diff --git a/output-json.c b/output-json.c
>> new file mode 100644
>> index 0000000..0eb66b2
>> --- /dev/null
>> +++ b/output-json.c
>> @@ -0,0 +1,128 @@
>> +#include "git-compat-util.h"
>> +#include "output.h"
>> +#include "strbuf.h"
>> +
>> +static char *json_quote(char *s)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +
>> +	while (*s) {
>> +		switch (*s) {
>> +...
>> +		default:
>> +			/* All control characters must be encode, even if they
>> +			 * don't have a specific escape character of their own */
>> +			if (*s < 0x20)
>> +				strbuf_addf(&buf, "\\u%04x", *s);
> 
> As you didn't say your "char" is either signed or unsigned upfront, this
> will behave differently when you are fed a UTF-8 string.  If it is
signed,
> you will end up showing bytes in a single letter separately at wrong
> codepoint, and if it is unsigned, you will give UTF-8 string unquoted,
> which probably is what you meant to do.

Oops. :(
Yep, unsigned it should have been.

> What is your design intention regarding legacy encoding?  This code does
> not yet declare "dear user, if you plan to use json/xml output, your
> repository metadata (notably the pathnames) has to be in UTF-8", as the
> caller _could_ transliterate legacy data before feeding it to output.c
> layer.  An alternative would be for the output.c layer to know about the
> encoding of incoming data and transliterate when the output format
> requires a particular encoding.

To be perfectly honest I had forgotten about encodings.  The code was
written with the thought that strings would be UTF-8 (except that even that
didn't work as you pointed out above).  Having English as your first
language doesn't help with this sort of thing.  I'm not even sure how to
create a file that has accented letters ... :$

Probably having the output_str function take UTF-8, and then having a
separate output_encoded_str that also takes an encoding might make sense? 
Unfortunately I have no idea how to convert an encoded string in git - a
quick grep suggests reenocde_string from utf8.h?

>> +static void json_obj_item_start(FILE *file, char *name, int first)
>> +{
>> +	char *quoted = json_quote(name);
>> +	if (!first)
>> +		fprintf(file, ",\n");
>> +	fprintf(file, "\"%s\" : ", quoted);
>> +	free(quoted);
>> +}
>> + ...
>> +static void json_str(FILE *file, char *value)
>> +{
>> +	char *quoted = json_quote(value);
>> +	fprintf(file, "\"%s\"", quoted);
>> +	free(quoted);
>> +}
> 
> An obvious improvement would be to make json_quote() to take FILE * to
> avoid wasteful allocation and copy, as it doesn't do anything but addstr
> and addch, and all of its callers don't do anything but spitting the
> result out to FILE *.

Yep, makes sense, thanks.

>> diff --git a/output-xml.c b/output-xml.c
>> new file mode 100644
>> index 0000000..50dd7d6
>> --- /dev/null
>> +++ b/output-xml.c
>> @@ -0,0 +1,68 @@
>> +#include "git-compat-util.h"
>> +#include "output.h"
> 
> This seems to totally lack quoting of any metacharacters for "name" and
> string "value".

Yep.  The XML output is still a long way from usable.  As I said in
another email, I mainly added it to see what different demands it placed on
the frontend/backend interface.  In future versions, I'll split out the XML
backend and try to make it clear that it's incomplete and only included in
the hope that someone who wants XML output takes it over ;).

-- 
Julian
