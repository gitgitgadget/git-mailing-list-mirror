From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add ls-files --eol-staged, --eol-worktree
Date: Sun, 18 Oct 2015 11:32:17 -0700
Message-ID: <xmqq8u70auz2.fsf@gitster.mtv.corp.google.com>
References: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de>
	<xmqqpp0caxlw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 18 20:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znsl5-0005s8-Ur
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 20:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbbJRSce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 14:32:34 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33536 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbbJRScU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 14:32:20 -0400
Received: by pabrc13 with SMTP id rc13so167646425pab.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wlOi8qJE3CixTe2gDpgjNVL/4/uTlrW3uwX84STkEiI=;
        b=TKyrAefXS8vv4Tza6x9vEDnW7kQALr9xeytmPjABEYJPkV1X6YibEftLZIEHivqwTZ
         gahDYkZGl8KF/01XktggcupFRadwOFWJe7TfMswrIsv0GTOkJeKh0G+jHHdng4TCTJSX
         N00k34U3E+sNqGODJ4PNL+8+2KC5lXRwR3aon7cmfJOWt7D0Z0WiKD8MGQkTU005wK1C
         UWifwI7q92pAMQi+y6lBYVkXWX9+f8WsVCOSMuoh+7o3/2t44LQNnM/9b6C/M405Cd2e
         iZZzrAaRdFNTWGKMmfIkTZC5zDledw6d4N/nVaIjuZ4sKvj3rRCz0b9HXDnDxFGcwsmM
         FdGg==
X-Received: by 10.68.190.105 with SMTP id gp9mr29502332pbc.152.1445193139759;
        Sun, 18 Oct 2015 11:32:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:305b:5af5:2c51:11cd])
        by smtp.gmail.com with ESMTPSA id u10sm32023697pbs.63.2015.10.18.11.32.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 11:32:18 -0700 (PDT)
In-Reply-To: <xmqqpp0caxlw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 18 Oct 2015 10:35:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279819>

Junio C Hamano <gitster@pobox.com> writes:

> If you say 1 and 2 are with LF, 4 and 6 are with CRLF, eveyrything
> else is mixed, then you are losing the distinction between 1 and 2
> (and 4 and 6) that you made when the files were a single liner (with
> or without the incomplete line ending).  Is that desirable?

Continuing this line of thought further.  My answer is "it may not
be desirable, but it is sufficient to decide what line ending to use
when I am adding a new line to the existing contents".  That is, to
a file with a single incomplete line, I can add my new line with
either LF or CRLF and the resulting one will become LF (or CRLF)
that ends in an incomplete line.  To a file whose lines consistently
use LF, I can only add my new line with LF, whether the original ends
in an incomplete line.

So from that point of view,...

> I wonder if it would be easier for the scripts that process the
> output from this command to handle if the report said what
> combination of _three_ possible line-ending is used.  i.e. does the
> file contain a line that ends with LF? does the file contain a line
> that ends with CRLF? does the file contain a line with missing EOL?

... instead of saying there are three possible line-endings, we can
stick to two, i.e. "is it text or binary" followed by "among two
possible endings, which ones are used", i.e.

    text
    text-lf
    text-crlf
    text-lf-crlf

which matches the last four lines of what you had in the "like this"
example (and I prefer "mixed" over "lf-crlf").

So I am OK with the categorization after all with respect to the
possible incomplete line at the end.  But if that is what the
feature is designed for, the documentation must say it very
clearly, i.e. "this is to allow you decide what line ending to use
when you add a new line to the existing contents" or something.

And viewed from that angle, there is no reason to special-case an
empty line.  Knowing "binary" is important because you want to be
able to say "whether LF or CRLF, you do *not* want to add your new
line to this binary file."; "empty" is just like "text"---you can
use either and get a coherent result.

So I'd suggest sticking to these classification tokens:

	binary
        text
        crlf
        mixed
        lf

The "adding my line at the beginning of the file" script can do
something like this using them (here I am simplifying by making your
feature available to "git get-eol" command that takes a single path
and does your computation):

	case "$(git get-eol file)" in
	text | lf)
        	printf "%s\n" "$mine"
                ;;
	crlf)
        	printf "%s\r\n" "$mine"
                ;;
        *) # that is 'binary' or 'mixed'
		die "do not muck with the contents of file"
                ;;
	esac
	cat file

Also this points at another direction of using the three independent
line ending conventions I suggested earlier.  What you want to
append your lines?  You would want to know if the file ends with an
incomplete line, so you would rather want to be told with a set of
categories like this instead:

	binary
	incomplete
        incomplete,crlf
        incomplete,mixed
        incomplete,lf
        crlf
        mixed
        lf

Note that an empty file will get an empty string as the grouping
above, as it does not have any line ending (i.e. no crlf/mixed/lf),
does not end with an incomplete line and is not a binary file.

And the using script would become:

	existing=$(git get-eol file)
	eol='\n'
	case ",$existing" in
	,binary | *,mixed)
		die "do not muck with the contents of file"
		;;
	,*crlf)
		eol='\r\n'
                ;;
	esac
        cat file
        case "$existing," in
        incomplete,*)
		printf "$eol"
                ;;
	esac
        printf "%s$eol" "$mine"
