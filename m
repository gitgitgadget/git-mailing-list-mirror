From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 2/2] archive.c: add support for --submodules[=(all|checkedout)]
Date: Sun, 25 Jan 2009 14:00:42 +0100
Message-ID: <8c5c35580901250500s667db3f0j608a30541321ac0a@mail.gmail.com>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
	 <1232844726-14902-2-git-send-email-hjemli@gmail.com>
	 <1232844726-14902-3-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901251247040.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 14:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR4cr-0003yu-Aw
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 14:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbZAYNAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 08:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbZAYNAo
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 08:00:44 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:53523 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbZAYNAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 08:00:43 -0500
Received: by wa-out-1112.google.com with SMTP id v33so333065wah.21
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 05:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CrOGhddqLbmNcIxfO3ar508eBYDbFP/a2c71sYzDEps=;
        b=icSlVSeYWdzbaHBco+4wrhsykKbHkfPeKc6DMtnMILa1VleBje3m8tcdf3p5F4I+Jr
         Dm7eCkjflCk7JkvEYOBjilJIdrbyqTTHgUGjcrhhUVKbqElvOoRnsCjBh37taY9EOarl
         akVDOv8pYHy9O3NtuYdxSiRqnARe0Fim4x80o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gQ6Q2OoFP5nLEvVIq3mT5Xlc3oUFjKVJQgl88/455o7Ft0TB8CL/XPL9H1h3a6NE9q
         f1fjl6Z6qnTPX47z0OxGL1EvPjARg9suAh2kOWbOPw5YNurAb9aybidofM5JlFt9OM7h
         arEpr9Om2i6gJX7DwqaagdALQyhbmVRgWUHdg=
Received: by 10.114.15.1 with SMTP id 1mr1614604wao.112.1232888442767; Sun, 25 
	Jan 2009 05:00:42 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901251247040.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 25, 2009 at 12:57, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 25 Jan 2009, Lars Hjemli wrote:
>
>> The --submodules option uses the enhanced read_tree_recursive() to
>> enable inclusion of submodules in the generated archive.
>>
>> When invoked with `--submodules=all` all gitlink entries will be
>> traversed, and when invoked with --submodules=checkedout (the default
>> option) only gitlink entries with a git repo (i.e. checked out sub-
>> modules) will be traversed.
>
>                               In bare repositories, this means: none.
>
> My reasoning for "*" instead of "all" and "" instead for "checkedout" was
> that you could allow "<name1>,<name2>" at some stage, where <name> would
> first be interpreted as a submodule group, and if that fails, as submodule
> name.
>
> Thinking about that more, "" seems illogical, that should rather mean
> "none", i.e. the same as --no-submodules.  The "checkedout" could be "."
> then, perhaps?  As in "what we have checked out in ./, the current
> directory"?

Yes, I think that makes sense, i.e. '--submodules' will include _all_
submodules (making the option behave identically for bare and non-bare
repositories), '--submodules=.' will include checked out submodules
(making the option a no-op in bare repos, which also makes sense) and
'--submodules=<name>[,<name>...]' will include the named submodules,
where "named" could mean groupname, submodule name or submodule path,
in that order.

But then we probably also want some (optional) syntax to specify the
kind of name, e.g. '--submodules=g:foo,n:bar,p:lib/baz' for group foo,
name bar and path lib/baz. Agree?

>
>> When a gitlink has been selected for traversal, it is required that all
>> objects necessary to perform this traversal are available in either the
>> primary odb or through an alternate odb. To this end, git archive will
>> insert the object database of the selected gitlink (when checked out)
>> as an alternate odb, using the new function add_alt_odb().
>
>> And since alternates now can be added after parsing of
>> objects/info/alternates, the error message in link_alt_odb_entry() has
>> been updated to not mention this file.
>
> Could you split that part into its own patch again, please?

Sure.


>
>> @@ -91,6 +92,70 @@ static void setup_archive_check(struct git_attr_check *check)
>>       check[1].attr = attr_export_subst;
>>  }
>>
>> +static int include_repository(const char *path)
>> +{
>> +     struct stat st;
>> +     const char *tmp;
>> +
>> +     /* Return early if the path does not exist since it is OK to not
>> +      * checkout submodules.
>> +      */
>> +     if (stat(path, &st) && errno == ENOENT)
>> +             return 1;
>> +
>> +     tmp = read_gitfile_gently(path);
>
> This will leak memory, no?

I don't think so: read_gitfile_gently() returns a value obtained by
calling make_absolute_path() which returns a static buffer. Also, the
path argument to include_repository() is obtained by calling mkpath()
which returns another static buffer so I don't see any malloc()'s
which should be free()'d. Is my code-reading flawed?

--
larsh
