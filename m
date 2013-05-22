From: Chico Sokol <chico.sokol@gmail.com>
Subject: Re: Reading commit objects
Date: Wed, 22 May 2013 11:47:31 -0300
Message-ID: <CABx5MBR=bvFEXhAiXgOfhkgVqhrYdjsWcWyHPc7+=bL-SW4vQA@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
 <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
 <CAJo=hJtqACW+CR5FkmDfwyK1Wg3Kcppy6DbW7P=On_qJyvsYvQ@mail.gmail.com> <CABx5MBSmCN=avRDCJ+RU8FoRDaGG=6uRfTdVR9m3A=SqpuKAjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Szakmeister <john@szakmeister.net>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 22 16:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfAKa-0004G9-Qp
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 16:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221Ab3EVOrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 10:47:52 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:62580 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034Ab3EVOrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 10:47:51 -0400
Received: by mail-vc0-f176.google.com with SMTP id ha11so1336376vcb.21
        for <git@vger.kernel.org>; Wed, 22 May 2013 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Vxdn2TXgubrOzPqVTgstH2TV/W1Y+R7xwCvj2Z5FjDs=;
        b=h87yLzTdiQVwuiSNe0fAX7fVmMH5cOR/be1Ou85rXUqkK2EXi3LAkmONRGRA0O8Pjt
         1DgTpBZ8VmGp2/1I4ecO5/OEHVfgMd+W0mb2EbuhppmQtCHhcv3ZB3oFQ4vBnyOEw6+x
         KYYyu+XEbhfoC+xVMiSAG645sifsOrx3iB+Yk+GBgqh04yiwcyUxHO5s4cYGXI6/f+mf
         YXPjLhz7xugyzAph83GgHxN+19JlKZM0WWyygdFUXxu4R39ZbxiiCWY/ObQU3o+gptfb
         J3MsQQE/hJY2PTlAlWef6D7eiZL7Ky6JGe3OQF6B5ci8t4sI9seQq6gRehASpExx55n+
         UDlw==
X-Received: by 10.58.225.228 with SMTP id rn4mr2883175vec.35.1369234071193;
 Wed, 22 May 2013 07:47:51 -0700 (PDT)
Received: by 10.220.80.10 with HTTP; Wed, 22 May 2013 07:47:31 -0700 (PDT)
In-Reply-To: <CABx5MBSmCN=avRDCJ+RU8FoRDaGG=6uRfTdVR9m3A=SqpuKAjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225166>

Solved! It was exaclty the problem pointed by Shawn.

Here is the working code:

File dotGit = new File("objects/25/0f67ef017fcb97b5371a302526872cfcadad21");
InflaterInputStream inflaterInputStream = new InflaterInputStream(new
FileInputStream(dotGit));
Integer read = inflaterInputStream.read();
while(read != 0) { //reading the bytes from 'commit <lenght>\0'
    read = inflaterInputStream.read();
    System.out.println((char)read.byteValue());
}
ByteArrayOutputStream os = new ByteArrayOutputStream();
IOUtils.copyLarge(inflaterInputStream, os);
System.out.println(new String(os.toByteArray()));

Thank you all!



--
Chico Sokol


On Wed, May 22, 2013 at 11:25 AM, Chico Sokol <chico.sokol@gmail.com> wrote:
>> Your code is broken. IOUtils is probably corrupting what you get back.
>> After inflating the stream you should see the object type ("commit"),
>> space, its length in bytes as a base 10 string, and then a NUL ('\0').
>> Following that is the tree line, and parent(s) if any. I wonder if
>> IOUtils discarded the remainder of the line after the NUL and did not
>> consider the tree line.
>
>
> Maybe you're right, Shawn. I've also tried the following code:
>
> File dotGit = new File("objects/25/0f67ef017fcb97b5371a302526872cfcadad21");
> InflaterInputStream inflaterInputStream = new InflaterInputStream(new
> FileInputStream(dotGit));
> ByteArrayOutputStream os = new ByteArrayOutputStream();
> IOUtils.copyLarge(inflaterInputStream, os);
> System.out.println(new String(os.toByteArray()));
>
> But we got the same result, I'll try to read the bytes by myself
> (without apache IOUtils). Is the contents of a unpacked object utf-8
> encoded?
