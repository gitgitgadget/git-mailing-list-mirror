From: Mathias Weber <mweb@gmx.ch>
Subject: Re: [PATCH] tag: add --author option
Date: Tue, 27 Mar 2012 22:32:16 +0200
Message-ID: <4F7223D0.5000801@gmx.ch>
References: <4F71E415.9030800@gmx.ch> <4F71F902.8090200@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Mar 27 22:33:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCd4Y-0003vq-LX
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 22:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab2C0UcV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 16:32:21 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:33823 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752373Ab2C0UcU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 16:32:20 -0400
Received: (qmail invoked by alias); 27 Mar 2012 20:32:18 -0000
Received: from 214-171.5-85.cust.bluewin.ch (EHLO [192.168.12.190]) [85.5.171.214]
  by mail.gmx.net (mp016) with SMTP; 27 Mar 2012 22:32:18 +0200
X-Authenticated: #1340516
X-Provags-ID: V01U2FsdGVkX1+PdvgOWbOPIqfawz0LDTqS/7Ed4h82Y6/GNJrRMG
	0pgU0KLCd7SXph
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <4F71F902.8090200@in.waw.pl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194083>

On 27.03.2012 19:29, Zbigniew J=C4=99drzejewski-Szmek wrote:
> On 03/27/2012 06:00 PM, Mathias Weber wrote:
>>
>> The tag command does not support the --author option as the
>> commit command. This adds the --author option to create
>> annotated tags with a different author.
>=20
> Consistency is good.

It would be good but during the rework of the patch I realized that for
the tag the committer is and should be used and not the author.
Therefore it is fine that this option isn't available. I'm sorry
bothering you.

Thanks for your help.

Mathias

>=20
>> Signed-off-by: Mathias Weber<mathew.weber@gmail.com>
>> ---
>>   builtin/tag.c |   26 +++++++++++++++++++++++---
>>   1 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index fe7e5e5..416fa88 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -309,17 +309,34 @@ struct create_tag_options {
>>
>>   static void create_tag(const unsigned char *object, const char *ta=
g,
>>                  struct strbuf *buf, struct create_tag_options *opt,
>> -               unsigned char *prev, unsigned char *result)
>> +               unsigned char *prev, unsigned char *result,
>> +               const char *force_author)
>>   {
>>       enum object_type type;
>>       char header_buf[1024];
>>       int header_len;
>>       char *path =3D NULL;
>> +    char *name, *email;
>> +    const char *author_ident;
>>
>>       type =3D sha1_object_info(object, NULL);
>>       if (type<=3D OBJ_NONE)
>>           die(_("bad object type."));
>>
>> +    if (force_author) {
>> +        const char *lb =3D strstr(force_author, "<");
>> +        const char *rb =3D strchr(force_author, '>');
>> +
>> +        if (!lb || !rb)
>> +            die(_("malformed --author parameter"));
>> +            name =3D xstrndup(force_author, lb - force_author);
>> +            email =3D xstrndup(lb + 2, rb - (lb + 2));
>=20
> This part is identical to builtin/commit.c, it would be nice to refac=
tor
> it into a function.
>=20
> Zbyszek
>=20
>> +
>> +        author_ident =3D fmt_ident(name, email, getenv("GIT_AUTHOR_=
DATE"),
>> +                IDENT_ERROR_ON_NO_NAME);
>> +    } else
>> +        author_ident =3D git_committer_info(IDENT_ERROR_ON_NO_NAME)=
;
>> +
>>       header_len =3D snprintf(header_buf, sizeof(header_buf),
>>                 "object %s\n"
>>                 "type %s\n"
>> @@ -328,7 +345,7 @@ static void create_tag(const unsigned char
>> *object, const char *tag,
>>                 sha1_to_hex(object),
>>                 typename(type),
>>                 tag,
>> -              git_committer_info(IDENT_ERROR_ON_NO_NAME));
>> +              author_ident);
>>
>>       if (header_len>  sizeof(header_buf) - 1)
>>           die(_("tag header too big."));
>> @@ -438,6 +455,7 @@ int cmd_tag(int argc, const char **argv, const
>> char *prefix)
>>           delete =3D 0, verify =3D 0;
>>       const char *msgfile =3D NULL, *keyid =3D NULL;
>>       struct msg_arg msg =3D { 0, STRBUF_INIT };
>> +    const char *force_author =3D NULL;
>>       struct commit_list *with_commit =3D NULL;
>>       struct option options[] =3D {
>>           OPT_BOOLEAN('l', "list",&list, "list tag names"),
>> @@ -452,6 +470,8 @@ int cmd_tag(int argc, const char **argv, const
>> char *prefix)
>>                       "annotated tag, needs a message"),
>>           OPT_CALLBACK('m', "message",&msg, "message",
>>                    "tag message", parse_msg_arg),
>> +        OPT_STRING(0, "author",&force_author, "author",
>> +                 "override author for annotated tag"),
>>           OPT_FILENAME('F', "file",&msgfile, "read message from file=
"),
>>           OPT_BOOLEAN('s', "sign",&opt.sign, "annotated and GPG-sign=
ed
>> tag"),
>>           OPT_STRING(0, "cleanup",&cleanup_arg, "mode",
>> @@ -556,7 +576,7 @@ int cmd_tag(int argc, const char **argv, const
>> char *prefix)
>>           die(_("Invalid cleanup mode %s"), cleanup_arg);
>>
>>       if (annotate)
>> -        create_tag(object, tag,&buf,&opt, prev, object);
>> +        create_tag(object, tag,&buf,&opt, prev, object, force_autho=
r);
>>
>>       lock =3D lock_any_ref_for_update(ref.buf, prev, 0);
>>       if (!lock)
>=20
>=20
