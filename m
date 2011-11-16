From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Wed, 16 Nov 2011 16:31:02 +0700
Message-ID: <CACsJy8CYj_s92zG-LnBKtHxV2uaG8-rq-VNJiQYwNJXGKbFeDw@mail.gmail.com>
References: <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net> <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org> <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net> <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net> <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com>
 <20111116085944.GA18781@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 10:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQbqG-0000g4-Jy
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 10:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab1KPJbe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 04:31:34 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57443 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab1KPJbd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 04:31:33 -0500
Received: by fagn18 with SMTP id n18so1208014fag.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 01:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Vm+7fPD+Us8macoMDUzocePNEILEeHXn8mpOIf8Kb1o=;
        b=XyPVhN3/fBl+N37+31NztqwOrOa5VqzQ1Jbnky5ie9gzkabHblnc59kOHfXO8Z138r
         G/K2WPzDBi+eK2BQ443DCr0QpggMEdR9Q4Xpp+ExbiK/z/D79528mb4X3MJHOWmss3wl
         OwmWVpcYNHJdmClfJShbwZGj8TKcPofXchADQ=
Received: by 10.205.124.144 with SMTP id go16mr20222124bkc.119.1321435892233;
 Wed, 16 Nov 2011 01:31:32 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 16 Nov 2011 01:31:02 -0800 (PST)
In-Reply-To: <20111116085944.GA18781@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185532>

On Wed, Nov 16, 2011 at 3:59 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguyen Thai Ngoc Duy wrote:
>
>> Or perhaps
> [...]
>> =C2=A0- git_path(const char *path) maintains a small hash table to k=
eep
>> track of all returned strings based with "path" as key.
>>
>> Out of 142 git_path() calls in my tree, 97 of them are in form
>> git_path("some static string").
>
> The main bit I dislike about patch 3/3 is that constructs like
> 'unlink(git_path("MERGE_HEAD"));' are not actually unsafe

Well, we can create wrappers (e.g. repo_unlink(const char *) that
calls git_path internally). According to grep/sed these functions are
used in form xxx(git_path(xxx))

     16 unlink
      8 file_exists
      7 stat
      6 fopen
      5 rename
      5 open
      4 unlink_or_warn
      3 safe_create_dir
      3 adjust_shared_perm
      3 access
      2 xstrdup
      2 safe_create_leading_directories
      2 rmdir
      2 remove_empty_directories
      2 opendir
      1 unable_to_lock_error
      1 read_attr_from_file
      1 mkdir
      1 lstat
      1 launch_editor
      1 add_excludes_from_file_to_list

By creating wrappers for unlink, file_exists, stat, fopen, rename and
open we can safely avoid git_pathdup()/free() in 42 places.
--=20
Duy
