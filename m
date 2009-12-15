From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Giving command line parameter to textconv command?
Date: Tue, 15 Dec 2009 12:11:10 +0900
Message-ID: <20091215121110.6117@nanako3.lavabit.com>
References: <20091215071735.6117@nanako3.lavabit.com> <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 04:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKNor-0001OJ-Jm
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 04:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759134AbZLODLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 22:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759131AbZLODLT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 22:11:19 -0500
Received: from karen.lavabit.com ([72.249.41.33]:35840 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759113AbZLODLS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 22:11:18 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 5540611B813;
	Mon, 14 Dec 2009 21:11:18 -0600 (CST)
Received: from 2659.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id VIGCXQUI952J; Mon, 14 Dec 2009 21:11:18 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=3Mfg/qwwXN2iwvOAdh4zYzJxvMFaikTAlW2R0vGFaNyX4ThDgiG5t/RzGHn6hwmMxl8b30hFJim1b0lpPXOKocdo3IueBhJoGHbxrORVS5ALUr/LnvckeIFiPWhgvumeKjNsi8ZifyoO0e0igDngHdGf4m7xbzZf+UKrKTnNiaQ=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135264>

Quoting Junio C Hamano <gitster@pobox.com>

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> I need this extra script because setting 'nkf -w' for
>> textconv like this
>>
>> 	[diff "eucjp"]
>> 		textconv = nkf -w
>>
>> gives an error.
>>
>> 	% diff --git a/hello.txt b/hello.txt
>> 	index 696acd7..f07aa1a 100644
>> 	error: cannot run nkf -w: No such file or directory
>> 	error: error running textconv command 'nkf -w'
>> 	fatal: unable to read files to diff
>>
>> Could you fix textconv so that it can be given parameters?
>
> The change to do so looks like this; it has a few side effects:
>
>  - If somebody else were relying on the fact that 'nkf -w' names the
>    entire command, it now will run 'nkf' command with '-w' as an argument,
>    and it will break such a set-up.  IOW, command that has an IFS white
>    space in its path will now need to be quoted from the shell.
>
>    You can see the fallout from this in the damage made to t/ hierarchy in
>    the attached patch.
>
>  - You can now use $HOME and other environment variables your shell
>    expands when defining your textconv command.
>
> Overall I think it is a good direction to go, but we need to be careful
> about how we transition the existing repositories that use the old
> semantics.
>
> We might need to introduce diff.*.xtextconv or something.

I experimented with other variables (eg. smudge and clean) and 
they honor their command line arguments. If textconv is the only 
setting that doesn't, the change may be easier to justify.

By the way, there should be a better description of the filters 
in the gitattributes documentation, similar to how [diff "name"] 
sections in the .git/config file are described.

-- >8 --
Subject: Illustrate "filter" attribute with an example

The example was taken from aa4ed402c9721170fde2e9e43c3825562070e65e
(Add 'filter' attribute and external filter driver definition).

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 1f472ce..5a45e51 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -197,6 +197,25 @@ intent is that if someone unsets the filter driver definition,
 or does not have the appropriate filter program, the project
 should still be usable.
 
+For example, in .gitattributes, you would assign the `filter`
+attribute for paths.
+
+------------------------
+*.c	filter=indent
+------------------------
+
+Then you would define a "filter.indent.clean" and "filter.indent.smudge"
+configuration in your .git/config to specify a pair of commands to
+modify the contents of C programs when the source files are checked
+in ("clean" is run) and checked out (no change is made because the
+command is "cat").
+
+------------------------
+[filter "indent"]
+	clean = indent
+	smudge = cat
+------------------------
+
 
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^






-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
