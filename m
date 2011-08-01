From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Mon, 1 Aug 2011 23:18:14 +0530
Message-ID: <CALkWK0mrx+3jdCQD9xya3AWMsPpSiZzEz+Z9XVxZNzw3UdKMVw@mail.gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-18-git-send-email-artagnon@gmail.com> <201107311751.52965.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwbY-0002r6-NJ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab1HARsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 13:48:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62677 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab1HARsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 13:48:35 -0400
Received: by wyg8 with SMTP id 8so1772943wyg.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mWs/vqKnvscSAAOd2qQCRtA9UosqGiArv59GE8Yz494=;
        b=RPsOglKfxoIHoaAvrdxcRMHAWv+Qiz729GpR/nNBsHXTk2VkeQzZHfSa/Y/7Dg8Lop
         dVIzuThaM+pbMwV4H9oVILlbIDvR2rhZdw8DqmZHOf0bVrFPFb8+cwpL8K0wA12H2MrC
         IWAOZFKJg3fvMs5wgt/HcbSYb4u57cOrQ6u/w=
Received: by 10.216.162.141 with SMTP id y13mr934543wek.94.1312220914249; Mon,
 01 Aug 2011 10:48:34 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 1 Aug 2011 10:48:14 -0700 (PDT)
In-Reply-To: <201107311751.52965.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178363>

Hi again,

Christian Couder writes:
> On Thursday 28 July 2011 18:52:30 Ramkumar Ramachandra wrote:
>> +static void read_populate_todo(struct commit_list **todo_list,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct replay_opts *opts)
>> +{
>> + =C2=A0 =C2=A0 const char *todo_file =3D git_path(SEQ_TODO_FILE);
>> + =C2=A0 =C2=A0 struct strbuf buf =3D STRBUF_INIT;
>> + =C2=A0 =C2=A0 struct commit_list **next;
>> + =C2=A0 =C2=A0 struct commit *commit;
>> + =C2=A0 =C2=A0 char *p;
>> + =C2=A0 =C2=A0 int fd;
>> +
>> + =C2=A0 =C2=A0 fd =3D open(todo_file, O_RDONLY);
>> + =C2=A0 =C2=A0 if (fd < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
>
> We don't need to release buf here.

Good catch!  Fixed.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno(_("Could not o=
pen %s."), todo_file);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (strbuf_read(&buf, fd, 0) < buf.len) {
>
> The other places in the code are using "strbuf_read(...) < 0" to dete=
ct an
> error.

Ah, I hadn't noticed.  See, strbuf_reset can return in two ways:
1. strbuf.c:313 reads "return -1", and this is clearly an error.
2. strbuf.c:322 reads "return sb->len - oldlen", and I thought I
should catch short reads using this.  Then again, malformed
instruction sheets are reported anyway during the parse anyway.

=46ixed for consistency with other code.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("Could not read %s=
=2E"), todo_file);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 close(fd);
>> +
>> + =C2=A0 =C2=A0 next =3D todo_list;
>> + =C2=A0 =C2=A0 for (p =3D buf.buf; *p; p =3D strchr(p, '\n') + 1) {
>
> This relies on a "\n" at the end of the last line...

Yes, that was intentional.  Every editor I know of inserts a '\n' at
the end of the last line, and I've seen some applications warn/ break
when the last line is not terminated with '\n'.  I suppose another
reason to not change this is consistency -- we don't have to handle
the last line using a special case.  So, I personally don't like it,
but I'll add a special case if you insist.

Thanks.

-- Ram
