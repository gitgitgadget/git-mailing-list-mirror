From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] stripspace: Implement --count-lines option
Date: Sun, 18 Oct 2015 10:18:53 -0700
Message-ID: <xmqqwpukayde.fsf@gitster.mtv.corp.google.com>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
	<1445008605-16534-4-git-send-email-tklauser@distanz.ch>
	<CAPig+cQ=8FO8yFY4sHUwr0mYuyvMu4d-eizHZeadE9f0BgpXpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 19:19:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znrbq-00022F-Of
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 19:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbbJRRS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 13:18:58 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33596 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104AbbJRRS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 13:18:57 -0400
Received: by pabrc13 with SMTP id rc13so166770084pab.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=akqm1ALHJiGMlzx0mLWoVdjyom6uTejJKf4G+oNMpbA=;
        b=grlu/oCD3HOzhAbADgJ+6R5CrvvmdNcLh2nFEUw/1ae/gycOik+ULio3KALqgBaVf7
         CkTPBP9sBuof2z18P8WtA+vO0psW/YV8TWxoD/jZVvJRBVy0cmnIXnupUDLCmXCyZ2jN
         yDJ+PAI18QtUxSpxIfT8I4J/IekEp+UBxsKFs0FUBcf7kaf121khVMYZhxBJY5tgbDaJ
         neMcWykSPcvfqD+s3ZzESPvxiwWXzzaeRtKLyCaqD/Ythk5e0GWZzqi9/+h23Lw6fyrX
         Osgph8giEbj87ePG8ankVdlAk82L/JnFYTfrMmI45uICZv33QK5mG5n10ti6cC/zHe3E
         o0wA==
X-Received: by 10.66.253.229 with SMTP id ad5mr29516957pad.101.1445188737078;
        Sun, 18 Oct 2015 10:18:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:305b:5af5:2c51:11cd])
        by smtp.gmail.com with ESMTPSA id x6sm31852260pbt.3.2015.10.18.10.18.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 10:18:54 -0700 (PDT)
In-Reply-To: <CAPig+cQ=8FO8yFY4sHUwr0mYuyvMu4d-eizHZeadE9f0BgpXpQ@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 17 Oct 2015 19:57:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279815>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Is there any application beyond git-rebase--interactive where a
> --count-lines options is expected to be useful? It's not obvious from
> the commit message that this change is necessarily a win for later
> porting of git-rebase--interactive to C since the amount of extra code
> and support material added by this patch probably outweighs the amount
> of code a C version of git-rebase--interactive would need to count the
> lines itself.
>
> Stated differently, are the two or three instances of piping through
> 'wc' in git-rebase--interactive sufficient justification for
> introducing extra complexity into git-stripspace and its documentation
> and tests?

Interesting thought.  When somebody rewrites "rebase -i" in C,
nobody needs to count lines in "stripspace" output.  The rewritten
"rebase -i" would internally run strbuf_stripspace() and the question
becomes what is the best way to let that code find out how many lines
the result contains.

When viewed from that angle, I agree that "stripspace --count" does
not add anything to further the goal of helping "rebase -i" to move
to C.  Adding strbuf_count_lines() that counts the number of lines
in the given strbuf (if there is no such helper yet; I didn't check),
though.

>> +test_expect_success '--count-lines with newline only' '
>> +       printf "0\n" >expect &&
>> +       printf "\n" | git stripspace --count-lines >actual &&
>> +       test_cmp expect actual
>> +'
>
> What is the expected behavior when the input is an empty file, a file
> with content but no newline, a file with one or more lines but lacking
> a newline on the final line? Should these cases be tested, as well?

Good point here, too.  If we were to add strbuf_count_lines()
helper, whoever adds that function needs to take a possible
incomplete line at the end into account.

Thanks for your comments.
