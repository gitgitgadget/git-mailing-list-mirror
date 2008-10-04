From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse parent..current syntax from pathinfo
Date: Sat, 4 Oct 2008 09:24:12 +0200
Message-ID: <cb7bb73a0810040024q4dfad117uf719f0aaa17ae95b@mail.gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222906234-8182-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222906234-8182-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810040331.27605.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 09:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Km1W0-0003VT-Rk
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 09:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYJDHYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 03:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbYJDHYO
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 03:24:14 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:40959 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYJDHYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 03:24:13 -0400
Received: by yx-out-2324.google.com with SMTP id 8so319937yxm.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3zPWipm3OdmBw1eTwqS/QlO8TGAEfelJ8VGpYutJCt4=;
        b=GF7VwBQoxapijoQRxy9qGSt1VyoNieeeAM/1P/BBTylwxezJ5BE8BElvgqlhf7Pzi3
         oUqcH64RsRzK93tK9mq5JQTzeV0fVg/A2W1z5ybvMndEwPCyZt+gdCR0aa6qvOZ16MfN
         +KC9Y55RqYWwWb1vI+NpM2aJiv4c1lffsdMqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hcPpYGVbUwOaJNVnj6qjIUEwEmoBg97+S0lUxomdp2NCGtoYbAUVEZzCZF9t36vnp1
         1vY2heVw/5AZ7GwGqMJAahQZFJx+lFPpS4s5iSG8rxEME18XIMJ6Y03+fg2EiQVKre2b
         2BbvOa3VmyVG+bLdWpKDnwWEwI/E1KnCMPKlY=
Received: by 10.151.141.8 with SMTP id t8mr3394544ybn.88.1223105052417;
        Sat, 04 Oct 2008 00:24:12 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Sat, 4 Oct 2008 00:24:12 -0700 (PDT)
In-Reply-To: <200810040331.27605.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97466>

On Sat, Oct 4, 2008 at 3:31 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:
>
>> This makes it possible to use an URL such as
>> $project/somebranch..otherbranch:/filename to get a diff between
>> different version of a file. Paths like
>> $project/$action/somebranch:/somefile..otherbranch:/otherfile are parsed
>> as well.
>>
>
> In short, it allows to have link to '*diff' views using path_info URL,
> or in general to pass $hash_[parent_]base and $file_parent using
> path_info.

Yes, that's probably a better form for the commit message.

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>>  gitweb/gitweb.perl |   26 ++++++++++++++++++++++++--
>>  1 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 3e5b2b7..89e360f 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -534,7 +534,9 @@ if ($path_info && !defined $action) {
>>
>>  # we can now parse ref and pathnames in PATH_INFO
>>  if ($path_info) {
>> -     my ($refname, $pathname) = split(/:/, $path_info, 2);
>> +     $path_info =~ /^((.+?)(:(.+))?\.\.)?(.+?)(:(.+))?$/;
>> +     my ($parentrefname, $parentpathname, $refname, $pathname) = (
>> +             $2, $4, $5, $7);
>
> Style: I would use (but that is perhaps matter of taste)
>
> +       my ($parentrefname, $parentpathname, $refname, $pathname) =
> +               ($2, $4, $5, $7);

Right, I'm not sure why I put the ( on the previous line.

> Also it would be I think simpler to use instead non-catching grouping,
> i.e. (?: xxx ) extended pattern (see perlre(1)), and use
> ($1, $2, $3, $4), or even simpler  'list = (string =~ regexp)'  form.

Good idea, I'll rework it in that sense.

> I also think that the situation is more complicated than that, if we
> want to be more correct.
>
> The following path_info layouts with '..' make sense:
>
>  hpb:fp..hb:f
>  hpb..hb:f     == hpb:f..hb:f
>  hp..h

And these are matched by the above regexp

> And the layout below can be though to make sense, but it is just
> plain weird.
>
>  hpb:fp..f     == hpb:fp..HEAD:f

I'm afraid I'm not going to support that, although it's probably easy
to support hpb:fp..:f (i.e. accept a missing refname but on condition
of having a : in front of the file spec).

>> +             if (defined $input_params{'file_parent'}) {
>> +                     $input_params{'hash_parent'} ||= git_get_hash_by_path($input_params{'hash_parent_base'}, $input_params{'file_parent'});
>
> This line is bit long, and I think it should be wrapped..

By the way, on the first revision of the path_info patchset, you had me discard

$hash      ||= git_get_hash_by_path($hash_base, $file_name);

in the simple case on the basis that it was an extra call to external git.

I actually forgot to remove it from this part of the patchset too at
the time, so this gets me wondering about this: should I put it back
in place in the simple case, or remove it from here too?


-- 
Giuseppe "Oblomov" Bilotta
