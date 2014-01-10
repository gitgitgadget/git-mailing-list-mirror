From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH mm/mv-file-to-no-such-dir-with-slash] mv: let 'git mv
 file no-such-dir/' error out on Windows, too
Date: Fri, 10 Jan 2014 20:21:58 +0100
Message-ID: <52D04856.9070005@kdbg.org>
References: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>	<52CD7DE8.6070101@kdbg.org> <xmqq7ga8aibn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 20:22:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1hf1-0002Bp-5C
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 20:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559AbaAJTWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 14:22:18 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:43745 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757396AbaAJTWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 14:22:16 -0500
Received: from bsmtp.bon.at (unknown [10.232.130.106])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 577F8CE5DC
	for <git@vger.kernel.org>; Fri, 10 Jan 2014 20:22:14 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5084510019;
	Fri, 10 Jan 2014 20:22:00 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 535AD19F6DB;
	Fri, 10 Jan 2014 20:21:59 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqq7ga8aibn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240311>

Am 09.01.2014 23:42, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> The previous commit c57f628 (mv: let 'git mv file no-such-dir/' error out)
>> relies on that rename("src", "dst/") fails if directory dst does not
>> exist (note the trailing slash). This does not work as expected on Windows:
>> This rename() call is successful. Insert an explicit check for this case.
> 
> Could you care to explain "Successful how" a bit here?  Do we see
> no-such-dir mkdir'ed and then no-such-dir/file created?  Do we see
> file moved to a new file whose name is no-such-dir/?  I am guessing
> that it would be the latter, but if that is the case we would need
> at least an air-quote around "successful".

The file is renamed to no-such-dir without the slash at the end. The
updated commit message would be:

mv: let 'git mv file no-such-dir/' error out on Windows, too

The previous commit c57f628 (mv: let 'git mv file no-such-dir/' error out)
relies on that rename("src", "dst/") fails if directory dst does not
exist (note the trailing slash). This does not work as expected on Windows:
The rename() call does not fail, but renames src to dst (without the
trailing slash). Insert an explicit check for this case to force an error.

This changes the error message from

   $ git mv file no-such-dir/
   fatal: renaming 'file' failed: Not a directory

to

   $ git mv file no-such-dir/
   fatal: destination directory does not exist, source=file, destination=no-such-dir/

Signed-off-by: Johannes Sixt <j6t@kdbg.org>

> 
>> This changes the error message from
>>
>>    $ git mv file no-such-dir/
>>    fatal: renaming 'file' failed: Not a directory
>>
>> to
>>
>>    $ git mv file no-such-dir/
>>    fatal: destination directory does not exist, source=file, destination=no-such-dir/
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  builtin/mv.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index 08fbc03..21c46d1 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -214,6 +214,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>  			}
>>  		} else if (string_list_has_string(&src_for_dst, dst))
>>  			bad = _("multiple sources for the same target");
>> +		else if (is_dir_sep(dst[strlen(dst) - 1]))
>> +			bad = _("destination directory does not exist");
>>  		else
>>  			string_list_insert(&src_for_dst, dst);
> 
