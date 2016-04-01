From: Johan Herland <johan@herland.net>
Subject: Re: What is an efficient way to get all blobs / trees that have notes attached?
Date: Fri, 1 Apr 2016 14:16:33 +0200
Message-ID: <CALKQrgdytYJtMTBHXbcRQ_iT5rWakZCxxqRW1rpLsPiSejud-Q@mail.gmail.com>
References: <ndljs8$vj3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 14:34:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alyHE-0001gg-RS
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 14:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbcDAMeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 08:34:08 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:57987 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbcDAMeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 08:34:07 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1aly0F-0000Sf-8w
	for git@vger.kernel.org; Fri, 01 Apr 2016 14:16:39 +0200
Received: from mail-yw0-f179.google.com ([209.85.161.179])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1aly0F-0001JO-2i
	for git@vger.kernel.org; Fri, 01 Apr 2016 14:16:39 +0200
Received: by mail-yw0-f179.google.com with SMTP id d68so16951512ywe.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 05:16:39 -0700 (PDT)
X-Gm-Message-State: AD7BkJLUWqvwXBUqP6TySd59IX6ZEd6eV2R/usopBhw5lp6XeSOtOCECqxbVz2aKOAEqlG2WiU9avfcRRhpwzg==
X-Received: by 10.129.147.2 with SMTP id k2mr12097418ywg.69.1459512993073;
 Fri, 01 Apr 2016 05:16:33 -0700 (PDT)
Received: by 10.37.75.133 with HTTP; Fri, 1 Apr 2016 05:16:33 -0700 (PDT)
In-Reply-To: <ndljs8$vj3$1@ger.gmane.org>
X-Gmail-Original-Message-ID: <CALKQrgdytYJtMTBHXbcRQ_iT5rWakZCxxqRW1rpLsPiSejud-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290532>

On Fri, Apr 1, 2016 at 12:51 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Hi,
>
> I'm curious whether there's a more efficient way to get a list of blobs /
> trees (and their names) that have notes attached than doing this:
>
> 1) Get all notes refs I'm interested in (git-for-each-ref).
>
> 2) For each notes ref, get the list of notes (git-notes list) and store them
> in a hash table that maps object hashes to notes.
>
> 3) Recursively list all blobs / trees (git-ls-tree) and look whether an
> object's hash is conatined in our table to get its notes.
>
> In particular 3) could be expensive for repos with a lot of files as we're
> looking at all of them just to see whether they have notes attached.

In (3), why would you need to search through _all_ blobs/trees? Would
it not be cheaper to simply query the object type of each annotated
object from (2)? I.e. something like:

for notes_ref in $(git for-each-ref refs/notes | cut -c 49-)
do
    echo "--- $notes_ref ---"
    for annotated_obj in $(git notes --ref=$notes_ref list | cut -c 41-)
    do
        type=$(git cat-file -t "$annotated_obj")
        if test "$type" != "commit"
        then
            echo "$annotated_obj: $type"
        fi
    done
done

Can probably be made even faster by using the --batch option to cat-file...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
