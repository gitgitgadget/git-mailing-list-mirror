From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Thu, 8 Oct 2015 18:47:04 +0530
Message-ID: <CAOLa=ZSuPZAPETH=-fUjBokgHScAHOFRhA=A3ei6tVL0V-=FwA@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com> <vpqr3l5zgst.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 08 15:17:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkB4r-0002uh-JU
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 15:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757533AbbJHNRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 09:17:36 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34270 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530AbbJHNRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 09:17:35 -0400
Received: by vkat63 with SMTP id t63so31457288vka.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2xVFckan1G9H4qf9rx6yFiCZ5XlUNmpweSw3z8NKWOY=;
        b=yMPN+ZV4HP7yogv9eMgGPUVG3X6VmNaZ9SkG7xN88iJH8n44QmX1iX+Q+btGykk8Z6
         1W/PkaU/LiaPAiXHST/QD02kQ3gRrWlJiHiG7G9dVJcc9y1siLI5VjThRp7qYo3rfGFo
         wiyFkY8AWWAF13ppJ//OfjVLlr2n7BB5gf/Q8uuxKrfHNfvtbrEnR8n0faN1IlArCVD0
         h/LluZmHvHI4JN2iikharrsJZYYxG33mu0tr3eJb3IvGPJ+6tZU9uBwp6kRJ9D9xu1Gy
         WHmnwEX1vG+HdkCW5JudsWpH154fEe00esny4+q5l7/Uc5unPB0Blv8xoxTginWQhii2
         0eIw==
X-Received: by 10.31.15.69 with SMTP id 66mr5078111vkp.142.1444310254264; Thu,
 08 Oct 2015 06:17:34 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Thu, 8 Oct 2015 06:17:04 -0700 (PDT)
In-Reply-To: <vpqr3l5zgst.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279241>

On Thu, Oct 8, 2015 at 5:57 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +An example to show the usage of %(if)...%(then)...%(else)...%(end).
>> +This prefixes the current branch with a star.
>> +
>> +------------
>> +#!/bin/sh
>> +
>> +git for-each-ref --format="%(if)%(HEAD)%(then)* %(else)  %(end)%(refname:short)" refs/heads/
>
> I don't think the #!/bin/sh adds any value here. Just the 'git
> for-each-ref' line is sufficient IMHO.
>

Sure, we can remove that.

>> +An example to show the usage of %(if)...%(then)...%(end).
>> +This adds a red color to authorname, if present
>
> I don't think this is such a good example.
> %(color:red)%(authorname)%(color:reset) just works even if %(authorname)
> is empty.
>
> A better example would be
>
> git for-each-ref --format='%(if)%(authorname)%(then)Authored by %(authorname)%(end)'
>
> which avoids writting "Authored by " with no author.
>

Yeah, will include this.

>> -static int is_empty(const char * s){
>> +static int is_empty(const char *s){
>
> You still have the { on the declaration line, it should be on the next
> line.
>

Oops, will change that.

>> @@ -309,10 +311,14 @@ static int is_empty(const char * s){
>>  static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>>  {
>>       struct ref_formatting_stack *cur = state->stack;
>> -     struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
>> +     struct if_then_else *if_then_else = NULL;
>>
>> +     if (cur->at_end == if_then_else_handler)
>> +             if_then_else = (struct if_then_else *)cur->at_end_data;
>
> OK, now the cast is safe since at_end_data has to be of type struct
> if_then_else * if at_end is if_then_else_handler.
>
>> +                             unsigned int nobracket = 0;
>> +
>> +                             if (!strcmp(valp, ",nobracket"))
>> +                                     nobracket = 1;
>
> The code to parse comma-separated values is different here and
> elsewhere. I'd rather have the same code (possibly factored into a
> helper function), both to get consistent behavior (you're not allowing
> %(upstream:nobracket,track) for example, right?) and consistent code.
>

Eh, okay, will do that!

>>                               if (!num_ours && !num_theirs)
>>                                       v->s = "";
>>                               else if (!num_ours) {
>> -                                     sprintf(buf, "[behind %d]", num_theirs);
>> +                                     if (nobracket)
>> +                                             sprintf(buf, "behind %d", num_theirs);
>> +                                     else
>> +                                             sprintf(buf, "[behind %d]", num_theirs);
>
> Perhaps use sprintf(buf, "%sbehind %d%s", obracket, num_their, cbracket)
> unconditionnally, and set obracket = "" or obracket = "[" once and for
> all when you test for "nobracket" above. This avoids these "if
> (nobracket)" spread accross the code, but at the price of extra %s in
> the format strings.
>

Okay! will do that.

>> @@ -1170,6 +1173,29 @@ static void populate_value(struct ref_array_item *ref)
>>                               else
>>                                       v->s = "<>";
>>                               continue;
>> +                     } else if (!strcmp(formatp, "dir") &&
>> +                                (starts_with(name, "refname"))) {
>> +                             const char *sp, *ep, *tmp;
>> +
>> +                             sp = tmp = ref->refname;
>> +                             /*  Obtain refs/foo/bar/ from refname refs/foo/bar/abc */
>> +                             do {
>> +                                     ep = tmp;
>> +                                     tmp = strchr(ep + 1, '/');
>> +                             } while (tmp);
>
> To look for the last occurence of '/' you can also use strrchr().
> Doesn't it do what you want here?
>

Didn't know that, thanks will do that.

>> --- a/t/t6040-tracking-info.sh
>> +++ b/t/t6040-tracking-info.sh
>> @@ -58,11 +58,11 @@ test_expect_success 'branch -v' '
>>  '
>>
>>  cat >expect <<\EOF
>> -b1 [origin/master] [ahead 1, behind 1] d
>> -b2 [origin/master] [ahead 1, behind 1] d
>> -b3 [origin/master] [behind 1] b
>> -b4 [origin/master] [ahead 2] f
>> -b5 [brokenbase] [gone] g
>> +b1 [origin/master: ahead 1, behind 1] d
>> +b2 [origin/master: ahead 1, behind 1] d
>> +b3 [origin/master: behind 1] b
>> +b4 [origin/master: ahead 2] f
>> +b5 [brokenbase: gone] g
>>  b6 [origin/master] c
>>  EOF
>
> Cool!
>
> I didn't go through the patches themselves, but modulo my remarks above
> the interdiff looks good. Thanks.
>

Thanks for the review.

-- 
Regards,
Karthik Nayak
