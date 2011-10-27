From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Fri, 28 Oct 2011 00:02:44 +0200
Message-ID: <CACBZZX7tghoHhxCygEj9DZSxvKyTvybawVA2HwHBkjBaH73Ujg@mail.gmail.com>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
 <1310084657-16790-3-git-send-email-gitster@pobox.com> <CACBZZX6Ss4jLtdrDhLUNKCUjEHjHHKzfv-LMkOyTPDhRUXm4sQ@mail.gmail.com>
 <CACBZZX6ZWOF=j-k8o-4NHmjS2HpyS+PmKjJh_QKevWurBf9pbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 00:03:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJY2z-0000hJ-8u
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 00:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060Ab1J0WDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 18:03:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56876 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab1J0WDF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 18:03:05 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so2391094bkb.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rVoU0NEQIdWwDdR/FQTjxQbgNUXUWiM17ADtIdpuyeA=;
        b=Oo+r0cO2XYMgEu3gRyr99JAemMPBthLC7QidYqZ3xCMWG5plMAJH2V7yc7Jart/4GB
         HIH9/qHrntNIapf870mKV1dSk1P/ZfP8iDYaxU3sleLwHTGLLzY2NGPSQhTGKHgCzF/n
         9pZMCFsTMlfpD5NRbgFipafkmiD5JHi+Uzy6w=
Received: by 10.204.10.81 with SMTP id o17mr893745bko.78.1319752984311; Thu,
 27 Oct 2011 15:03:04 -0700 (PDT)
Received: by 10.204.112.79 with HTTP; Thu, 27 Oct 2011 15:02:44 -0700 (PDT)
In-Reply-To: <CACBZZX6ZWOF=j-k8o-4NHmjS2HpyS+PmKjJh_QKevWurBf9pbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184321>

On Thu, Oct 27, 2011 at 23:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

> Actually it just seems slow in general, not just on repositories with
> a lot of tags, on linux-2.6.git with this patch:

Here's profiling with gprof for everything with >1% of execution time
with the patch applied:

    Each sample counts as 0.01 seconds.
      %   cumulative   self              self     total
     time   seconds   seconds    calls   s/call   s/call  name
     21.07     15.99    15.99  2184059     0.00     0.00
add_descendants_to_write_order
     20.25     31.35    15.37 1146371554     0.00     0.00  add_to_writ=
e_order
     11.94     40.41     9.06 142180385     0.00     0.00  hashcmp
      5.55     44.62     4.21 90592818     0.00     0.00  lookup_object
      4.64     48.14     3.52 72804470     0.00     0.00  hashcmp
      3.87     51.08     2.94 90007452     0.00     0.00  get_mode
      3.31     53.59     2.51 90007452     0.00     0.00  decode_tree_e=
ntry
      1.90     55.03     1.44  2184059     0.00     0.00
add_family_to_write_order
      1.79     56.39     1.36 43247856     0.00     0.00  hashcmp
      1.29     57.37     0.98                             pack_offset_s=
ort
      1.27     58.33     0.96 90007452     0.00     0.00  update_tree_e=
ntry
      1.27     59.29     0.96 90592817     0.00     0.00  hashtable_ind=
ex
      1.20     60.20     0.91  4009188     0.00     0.00  find_pack_rev=
index
      1.19     61.10     0.90  5899321     0.00     0.00  find_pack_ent=
ry_one
      1.12     61.95     0.85   269514     0.00     0.00
commit_list_insert_by_date
      1.08     62.77     0.82  5387773     0.00     0.00  patch_delta

And without:

    Each sample counts as 0.01 seconds.
      %   cumulative   self              self     total
     time   seconds   seconds    calls   s/call   s/call  name
     21.29      9.13     9.13 142180385     0.00     0.00  hashcmp
     10.59     13.67     4.54 90592818     0.00     0.00  lookup_object
      8.48     17.31     3.64 72638478     0.00     0.00  hashcmp
      6.60     20.14     2.83 90007452     0.00     0.00  decode_tree_e=
ntry
      6.15     22.77     2.64 90007452     0.00     0.00  get_mode
      2.99     24.05     1.28 43247182     0.00     0.00  hashcmp
      2.96     25.32     1.27 90592817     0.00     0.00  hashtable_ind=
ex
      2.47     26.38     1.06 90007452     0.00     0.00  update_tree_e=
ntry
      2.26     27.35     0.97  4009188     0.00     0.00  find_pack_rev=
index
      2.05     28.23     0.88   269245     0.00     0.00  process_tree
      1.96     29.07     0.84   269514     0.00     0.00
commit_list_insert_by_date
      1.94     29.90     0.83                             pack_offset_s=
ort
      1.73     30.64     0.74  5389900     0.00     0.00  patch_delta
      1.70     31.37     0.73  5885588     0.00     0.00  find_pack_ent=
ry_one
      1.38     31.96     0.59  8692967     0.00     0.00  hashcmp
      1.24     32.49     0.53  8175096     0.00     0.00
unpack_object_header_buffer
      1.14     32.98     0.49        1     0.49     0.59  write_idx_fil=
e
      1.12     33.46     0.48  5885588     0.00     0.00
nth_packed_object_offset
      1.12     33.94     0.48  6051632     0.00     0.00
locate_object_entry_hash
