From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git add -A fails in empty repository since 1.8.5
Date: Wed, 18 Dec 2013 18:59:31 +0700
Message-ID: <CACsJy8DY7eZm7-P=azJF-jEiBKM_QPf_GXG3uzbuw5C1vq1Q5A@mail.gmail.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
 <CALWbr2wXxSU4qD_Gj5P7aYxB39tEVBa-TDALVepuwZLh+RNU1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 13:00:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtFnO-0000Mr-6s
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 13:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab3LRMAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 07:00:04 -0500
Received: from mail-qa0-f44.google.com ([209.85.216.44]:48294 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab3LRMAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 07:00:02 -0500
Received: by mail-qa0-f44.google.com with SMTP id i13so3604250qae.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 04:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=465IAm8HvImVUGw1nJ0R0+zt9uMZAwnvWBQw+4wHeVE=;
        b=zIVAAIE50tnherU0U7pyIeONhElFQtkv1+loRk3dPu+J+kpbSXaMK2K2oQij8kKCnn
         6r+zulsEtrFgcMdrvdxGrHQMro1AXcitqNccd0mXc96Jmc/qWmj67uPBulPz5ZpkSbz3
         VDKpCxS32Q0LiQHL5RGxOuLx3xqhNCsZ5pm8W2uU1ByssAmcgRgA0/lfPkJM3yUUya+n
         rLl+9DeH6cB2YsZlrjkHsoRkY/A3L/HHG7j4+LrNog+602zkNJwEyjgFOvT3ruYo5ghs
         FFtShcIT0Jh14LU/5cWuji+dICNr3W1MGbj6+9KFsm2Mh7wjEiRHYeQLMkFdM9OFFtOe
         KeFg==
X-Received: by 10.224.157.19 with SMTP id z19mr52594028qaw.102.1387368001447;
 Wed, 18 Dec 2013 04:00:01 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Wed, 18 Dec 2013 03:59:31 -0800 (PST)
In-Reply-To: <CALWbr2wXxSU4qD_Gj5P7aYxB39tEVBa-TDALVepuwZLh+RNU1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239428>

On Wed, Dec 18, 2013 at 3:44 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> FWIW, git-bisect points to 84b8b5d (that is $gmane/230349).
>
> On Wed, Dec 18, 2013 at 9:06 AM, Thomas Ferris Nicolaisen
> <tfnico@gmail.com> wrote:
>> This was discussed on the Git user list recently [1].
>>
>> #in a repo with no files
>>> git add -A
>> fatal: pathspec '.' did not match any files
>>
>> The same goes for git add . (and -u).
>>
>> Whereas I think some warning feedback is useful, we are curious
>> whether this is an intentional change or not.

I was not aware of this case when I made the change. It's caused by
this change that removes pathspec.raw[i][0] check in builtin/add.c in
84b8b5d .

-               for (i = 0; pathspec.raw[i]; i++) {
-                       if (!seen[i] && pathspec.raw[i][0]
-                           && !file_exists(pathspec.raw[i])) {
+               for (i = 0; i < pathspec.nr; i++) {
+                       const char *path = pathspec.items[i].match;
+                       if (!seen[i] && !file_exists(path)) {

Adding it back requires some thinking because "path" in the new code
could be something magic.. and the new behavior makes sense, so I'm
inclined to keep it as is, unless people have other opinions.

>>
>> [1] https://groups.google.com/d/topic/git-users/Qs4YSPhTsqE/discussion
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
