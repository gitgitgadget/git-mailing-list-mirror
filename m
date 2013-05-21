From: Chico Sokol <chico.sokol@gmail.com>
Subject: Re: Reading commit objects
Date: Tue, 21 May 2013 19:18:35 -0300
Message-ID: <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Wed May 22 00:19:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueuti-0001iC-H2
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 00:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab3EUWS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 18:18:57 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:51991 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3EUWS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 18:18:56 -0400
Received: by mail-vc0-f170.google.com with SMTP id gf11so864416vcb.29
        for <git@vger.kernel.org>; Tue, 21 May 2013 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JlWJ4ddoH10oWi1jfu4G9XtxaL/OKngXK4yZj1uCBzM=;
        b=dS96lsVaEebCkcs7ZtlkMmXgddSPZxbxO2RcnLF0NLwXwiktyRR1VhFYFzAIC3Tx6q
         ijADvpLG3m73pWQy/vB9xHaOnj27h5khE6iDFBHkQvKsG0oM/cEQGK0e6w2aGm7jevfx
         NUMolOM8Qwz0z1SVMXdZ6HPekwYsZsqhYbhuj3ToBCxkYDU5V/ki/kKvq6yzI04TAMPt
         U8jSZy6fOf+gp0jNZ0jqE8FHS8L5B7Ak/j4k6aLRXv4j+RGYB30+ghAdf7ZVWOIuzgl7
         1ViOEvMc1RZ7RCkGmtV6ae3o7WkxtOc9llFSpkTuTrC9/H5Exc2zEohlMlZUCmbJbqCJ
         f4Rg==
X-Received: by 10.52.240.211 with SMTP id wc19mr1522282vdc.12.1369174735308;
 Tue, 21 May 2013 15:18:55 -0700 (PDT)
Received: by 10.220.80.10 with HTTP; Tue, 21 May 2013 15:18:35 -0700 (PDT)
In-Reply-To: <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225084>

Ok, we discovered that the commit object actually contains the tree
object's sha1, by reading its contents with python zlib library.

So the bug must be with our java code (we're building a java lib).

Is there any non-standard issue in git's zlib compression? We're
decompressing its contents with java default zlib api, so it should
work normally, here's our code, that's printing that wrong output:

import java.io.File;
import java.io.FileInputStream;
import java.util.zip.InflaterInputStream;
import org.apache.commons.io.IOUtils;
...
File obj = new File(".git/objects/25/0f67ef017fcb97b5371a302526872cfcadad21");
InflaterInputStream inflaterInputStream = new InflaterInputStream(new
FileInputStream(obj));
System.out.println(IOUtils.readLines(inflaterInputStream));


I know that here it's not the right place to ask about java issues,
but we would appreciate any help any help.



--
Chico Sokol


On Tue, May 21, 2013 at 6:37 PM, John Szakmeister <john@szakmeister.net> wrote:
> On Tue, May 21, 2013 at 5:21 PM, Chico Sokol <chico.sokol@gmail.com> wrote:
>> Hello,
>>
>> I'm building a library to manipulate git repositories (interacting
>> directly with the filesystem).
>>
>> Currently, we're trying to parse commit objects. After decompressing
>> the contents of a commit object file we got the following output:
>>
>> commit 191
>> author Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
>> committer Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
>>
>> first commit
>
> Does `git cat-file -p <sha1>` show a tree object?  FWIW, I expected to
> see a tree line there, so maybe this object was created without a
> tree?  I also don't see a parent listed.
>
> I did this on one of my repos:
>
>>>> buf = open('.git/objects/cd/da219e4d7beceae55af73c44cb3c9e1ec56802', 'rb').read()
>>>> import zlib
>>>> zlib.decompress(buf)
> 'commit 246\x00tree 2abfe1a7bedb29672a223a5c5f266b7dc70a8d87\nparent
> 0636e7ff6b79470b0cd53ceacea88e7796f202ce\nauthor John Szakmeister
> <john@szakmeister.net> 1369168481 -0400\ncommitter John Szakmeister
> <john@szakmeister.net> 1369168481 -0400\n\nGot a file listing.\n'
>
> So at least creating the commits with Git, I see a tree.  How was the
> commit you're referencing created?  Perhaps something is wrong with
> that process?
>
>> We hoped to get the same output of a "git cat-file -p <sha1>", but
>> that didn't happened. From a commit object, how can I find tree object
>> hash of this commit?
>
> I'd expect that too.
>
> -John
