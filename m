From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 23:46:23 -0700
Message-ID: <832adb090806112346r12c34d2bibf822f8422b349c5@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <20080612031723.GJ11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 08:47:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6gas-0007OE-DZ
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 08:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbYFLGq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 02:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758294AbYFLGq1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 02:46:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:20375 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbYFLGqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 02:46:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2383253fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 23:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=769tYl1o95oTxhAGODqh9CCD+lUxPoDZLJpgEiX/grc=;
        b=O3q2x0B4H5kppC9qb8lKWt9Rhho5gkBoGsGNGRv+eOCC/zVNghkABXjLq+9G+VxpqK
         lMVdMb/fUe792m40tR/DorPOpHbBTlZKXO7Qgo9Peq3n8upCPFizIgn40669fygSnKvk
         8aoh8lS5EQCeeZ922FySHF/jGACqfG7gas7XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I710ysNodPe96pYwplSur/Dxn7k36q+YKghfGWmp8NuxrHVpCuWNr7ztyKsrZpe0D/
         z6nKsgjbQ4Iy810Xg0650G++LackKpDplBrF61Hagb2ythjK/aZOZB2Ft+6x4oEjE0Hh
         WnWNgTT5HZ6k9r+f4aRbjNIzrLA8oUmioqJ4o=
Received: by 10.86.60.15 with SMTP id i15mr1591667fga.53.1213253183796;
        Wed, 11 Jun 2008 23:46:23 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Wed, 11 Jun 2008 23:46:23 -0700 (PDT)
In-Reply-To: <20080612031723.GJ11793@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84723>

Thanks! I just tested it on the example I quoted before, and it works.
I misunderstood the reset command. I thought it took you to some
previous commit. But now I see it takes you back to before the initial
commit if you don't use the "from" command.

-Ben

On Wed, Jun 11, 2008 at 8:17 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Ben Lynn <benlynn@gmail.com> wrote:
>> 1. The import/export language poorly handles distinct initial commits
>> on the same branch, because given two commits with same branch name,
>> it assumes the latter is the descendant of the former (if there are no
>> "from" commands).
>>
>> Normally this is what you want. But if your project, like git, ever
>> merges distinct initial commits, then all but the first will
>> unexpectedly gain parents, corrupting all their descendants' hashes.
> ...
>> As a workaround, I have a custom importer that knows that
>> git-fast-export omits the "from" command in initial commits. But there
>> should be a command to specify that the current commit is an initial
>> commit, allowing reliable export of projects such as git.
>
> fast-export is wrong, and is using the language wrong.  fast-import
> is correct.  Because I said so.  :-)
>
> No, seriously, fast-import came along first and can describe what
> you are referring to as the many initial root commits in git.git.
> The issue is fast-export is not generating commands to say as much.
>
> Its quite easily fixable.
>
> When we output a commit in handle_commit() we just need to reset
> the branch if we have no parents.  That simple.  This is totally
> untested, but I think it fixes it.
>
>
> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 1dfc01e..d0a462f 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -188,6 +188,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>        mark_object(&commit->object);
>        if (!is_encoding_utf8(encoding))
>                reencoded = reencode_string(message, "UTF-8", encoding);
> +       if (!commit->parents)
> +               printf("reset %s\n", (const char*)commit->util);
>        printf("commit %s\nmark :%d\n%.*s\n%.*s\ndata %u\n%s",
>               (const char *)commit->util, last_idnum,
>               (int)(author_end - author), author,
>
> --
> Shawn.
>
