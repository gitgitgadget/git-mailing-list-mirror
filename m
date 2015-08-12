From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCHv3 1/2] config: add '--names-only' option to list only
 variable names
Date: Thu, 13 Aug 2015 01:47:36 +0200
Message-ID: <20150813014736.Horde.GbbN2TpIOFaNM_MPXUzZ4Q2@webmail.informatik.kit.edu>
References: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
 <1439199967-9655-2-git-send-email-szeder@ira.uka.de>
 <xmqqvbcnuko6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 01:47:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPfkU-0003Sg-0l
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 01:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbbHLXrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2015 19:47:53 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:42654 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495AbbHLXrw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 19:47:52 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZPfkD-0001fV-Oh; Thu, 13 Aug 2015 01:47:41 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZPfk8-0001Du-GQ; Thu, 13 Aug 2015 01:47:36 +0200
Received: from x4db02839.dyn.telefonica.de (x4db02839.dyn.telefonica.de
 [77.176.40.57]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 13 Aug 2015 01:47:36 +0200
In-Reply-To: <xmqqvbcnuko6.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1439423261.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275829>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> 'git config' can only show values or name-value pairs, so if a shell
>> script needs the names of set config variables it has to run 'git co=
nfig
>> --list' or '--get-regexp' and parse the output to separate config
>> variable names from their values.  However, such a parsing can't cop=
e
>> with multi-line values.  Though 'git config' can produce null-termin=
ated
>> output for newline-safe parsing, that's of no use in such a case, be=
case
>
> s/becase/because/;

OK.

>> shells can't cope with null characters.
>>
>> Even our own bash completion script suffers from these issues.
>>
>> Help the completion script, and shell scripts in general, by introdu=
cing
>> the '--names-only' option to modify the output of '--list' and
>> '--get-regexp' to list only the names of config variables, so they d=
on't
>> have to perform error-prone post processing to separate variable nam=
es
>> from their values anymore.
>
> I agree with Peff that "--names-only" has a subtle difference with
> an existing and well known subcommand option and it would be a bit
> irritating to remember which options is for which command.

OK.

>> diff --git a/builtin/config.c b/builtin/config.c
>> index 7188405f7e..307980ab50 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -13,6 +13,7 @@ static char *key;
>>  static regex_t *key_regexp;
>>  static regex_t *regexp;
>>  static int show_keys;
>> +static int omit_values;
>>  static int use_key_regexp;
>>  static int do_all;
>>  static int do_not_match;
>> ...
>> @@ -91,7 +93,7 @@ static void check_argc(int argc, int min, int max)=
 {
>>
>>  static int show_all_config(const char *key_, const char *value_, vo=
id *cb)
>>  {
>> -	if (value_)
>> +	if (!omit_values && value_)
>
> Hmmmm.  As we have "show_keys",
>
> 	if (show_values && value_)
>
> would be a lot more intuitive, no?

Well, the name 'omit_values' was suggested by Peff after the first =20
round.  I'm happy to rename it to whatever you agree upon :)


>> @@ -117,6 +119,10 @@ static int format_config(struct strbuf *buf, =20
>> const char *key_, const char *value
>>  		strbuf_addstr(buf, key_);
>>  		must_print_delim =3D 1;
>>  	}
>> +	if (omit_values) {
>> +		strbuf_addch(buf, term);
>> +		return 0;
>> +	}
>
> This hunk makes me wonder what the assignment to "must_print_delim"
> is about.  When the code is told to show only keys and not values,
> it shouldn't even have to worry about key_delim, but that assignment
> is done to control exactly that.  It happens that you are lucky that
> you can "return 0" early here so that the assignment does not have
> any effect, but still conceptually the code structure is made ugly
> by this patch.

How about restructuring the function like this?  Perhaps even better =20
than a tri-state toggle would be.
(showing the result instead of the diff, because all the indentation =20
changes make the diff hard to read).

static int format_config(struct strbuf *buf, const char *key_, const =20
char *value_)
{
         strbuf_init(buf, 0);

         if (show_keys)
                 strbuf_addstr(buf, key_);
         if (!omit_values) {                  // or show_values
                 int must_free_vptr =3D 0;
                 int must_add_delim =3D show_keys;
                 char value[256];
                 const char *vptr =3D value;

                 if (types =3D=3D TYPE_INT)
                         sprintf(value, "%"PRId64,
                                 git_config_int64(key_, value_ ? value_=
 : ""));
                 else if (types =3D=3D TYPE_BOOL)
                         vptr =3D git_config_bool(key_, value_) ? "true=
" =20
: "false";
                 else if (types =3D=3D TYPE_BOOL_OR_INT) {
                         int is_bool, v;
                         v =3D git_config_bool_or_int(key_, value_, &is=
_bool);
                         if (is_bool)
                                 vptr =3D v ? "true" : "false";
                         else
                                 sprintf(value, "%d", v);
                 } else if (types =3D=3D TYPE_PATH) {
                         if (git_config_pathname(&vptr, key_, value_) <=
 0)
                                 return -1;
                         must_free_vptr =3D 1;
                 } else if (value_) {
                         vptr =3D value_;
                 } else {
                         /* Just show the key name */
                         vptr =3D "";
                         must_add_delim =3D 0;
                 }

                 if (must_add_delim)
                         strbuf_addch(buf, key_delim);
                 strbuf_addstr(buf, vptr);

                 if (must_free_vptr)
                         free((char *)vptr);
         }
         strbuf_addch(buf, term);
         return 0;
}


>
> Isn't it more like the existing "show_keys" can be replaced/enhanced
> with a single "show" tri-state toggle that chooses one among:
>
>     * show both keys and values (for --list)
>     * show only keys (for your new feature)
>     * show only value (for --get)
>
> perhaps?
>
> I see get_urlmatch() abuses show_keys variable in a strange way, and
> it may not be as trivial as removing show_keys and replacing it with
> a new tri-state toggle, though.
