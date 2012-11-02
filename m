From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 09/14] remote-testgit: report success after an import
Date: Fri, 2 Nov 2012 16:46:39 +0100
Message-ID: <CAMP44s2ZPbda7yJ9UtOhWMqaKp4TaAgoyeUWUSrt0vco7RK+Tw@mail.gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
	<1351821738-17526-10-git-send-email-felipe.contreras@gmail.com>
	<5093D193.3030108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:46:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJSQ-0003oc-GB
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935Ab2KBPql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 11:46:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55914 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849Ab2KBPqk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:46:40 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3728863obb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x8Xq6WbZlEja3NI3kBB5YooiUkbAYdrQn3sw99cy/UA=;
        b=0LEntDsi7zR8TIfbR9BstZhVtviipM6k/L+GL1VPlISXgOFw48sNK61PymCYy6iQqJ
         CepniA9ve8FVUyz92UdXZJjhV3ciDdPSX0gqg6tsQuCGrfkqOMOWwpGttipO/JhmEmZF
         SPqtN2fWgONYgTJBDLCv+ZfGgU1K5CcmJ+GLCri/Gvy813sqZq2nHDh76rna4YRVkTU/
         rAutfUNFYEKJv6+Nt3C6N4wgn9oI9bnwABegAP4OokJ8SKakmm/c23Etd/1DEw+FdBeX
         Bd/n2MzjMy/w3jhSpw7E8Ey5CnJip9LZ9Lbh9ndeIpPGEDTwoSdDnyOatHVaQmMxdBRh
         m/1g==
Received: by 10.182.235.46 with SMTP id uj14mr1665990obc.40.1351871199847;
 Fri, 02 Nov 2012 08:46:39 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 08:46:39 -0700 (PDT)
In-Reply-To: <5093D193.3030108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208955>

On Fri, Nov 2, 2012 at 2:58 PM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:
> On 11/02/2012 03:02 AM, Felipe Contreras wrote:
>> Doesn't make a difference for the tests, but it does for the ones
>> seeking reference.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  git-remote-testgit | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/git-remote-testgit b/git-remote-testgit
>> index 6c348b0..4e8b356 100755
>> --- a/git-remote-testgit
>> +++ b/git-remote-testgit
>> @@ -59,7 +59,18 @@ while read line; do
>>              sed -e "s#refs/heads/#${prefix}/heads/#g"
>>          ;;
>>      export)
>> +        declare -A before after
>> +
> If you convert this script to be a valid POSIX shell script (as I've
> suggested in my reply to [PATCH v4 04/14]), you'll need to get rid of
> this bashism (and those below) as well.

Yeah, but I don't want to. I originally used transitory files, and
used esoteric options of diff to do the same (which were probably not
portable).

In the end I liked this approach much better.

If you have a solution for this that works in POSIX shell, I'll be
glad to consider it, but for the moment, I think a simple, easy to
understand and maintain code is more important, and if it needs bash,
so be it.

>> +        eval $(git for-each-ref --format='before[%(refname)]=%(objectname)')
>> +
>>          git fast-import --{import,export}-marks="$testgitmarks" --quiet
>> +
>> +        eval $(git for-each-ref --format='after[%(refname)]=%(objectname)')
>> +
>> +        for ref in "${!after[@]}"; do
>> +            test "${before[$ref]}" ==  "${after[$ref]}" && continue
>> +            echo "ok $ref"
>> +        done
>>          echo
>>          ;;
>>      '')

Cheers.

-- 
Felipe Contreras
