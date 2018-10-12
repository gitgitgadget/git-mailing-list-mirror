Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7AF1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 00:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJLHxn (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 03:53:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41667 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJLHxn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 03:53:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id l197-v6so8560797oib.8
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 17:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkAo46NlgQDrVWnsLplllTYSndhkH3U7hpUj+XifQ14=;
        b=AS6KAv3sA0hRA2n5Bk/7EdgVomP6+XwaGPENCgynya2Pu117CFtRmXSLlm38qZN3dL
         M9FOHxF0JnQ7AvbjmUzhCLwdO9Lk1IG0R0dl1dAzBYPn2/G5ahTEMN19CoBF8moKCvUq
         UjWx5C0hKMNY7WDkWZZ7IEKkzAL56BNni5CMAv7VAFIOusRckaMu+7dy/MwSsSt3kL9E
         BweeX5pcfnmEnxaxgUfK8s1Q/3K3jsB+rXm/iXQMgjrflX9e0E8o23luhLGncGXImwjc
         mjZR2yIMSCllbeTlRYLm30Anx9FfmTg/eveYcvTZ1vW2w77DX15kP0A+1yy0AVIlA0iI
         ybsw==
X-Gm-Message-State: ABuFfohaPzDOEQdDdxra7jgJHGp0qRQOko5mSJPwoSacM8eU2oaeSMmM
        w9VIVuJE8pOMfPYOVD8zjDdnkfWb4GEk4d8Z05GaZ0+D
X-Google-Smtp-Source: ACcGV61U1paF6x4sjJ9U2Ezn8CpPm+Fe/vXdWKzhERQQaoqsDjtknQWEoPUKEa8Cc2ougGucXuLkZpWSzBUrMU9AIP8=
X-Received: by 2002:a54:4390:: with SMTP id u16-v6mr2160944oiv.186.1539303842051;
 Thu, 11 Oct 2018 17:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181010003743.17198-1-npostavs@users.sourceforge.net> <xmqqzhvmmv8v.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhvmmv8v.fsf@gitster-ct.c.googlers.com>
From:   Noam Postavsky <npostavs@users.sourceforge.net>
Date:   Thu, 11 Oct 2018 20:23:46 -0400
Message-ID: <CAM-tV--Jzq6DOAfWtvk3FVX3=TT8X6bvu_4VfaJQY=M0mSQV4w@mail.gmail.com>
Subject: Re: [PATCH v6] log: fix coloring of certain octupus merge shapes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b518330577fd1a4f"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000b518330577fd1a4f
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Oct 2018 at 21:43, Junio C Hamano <gitster@pobox.com> wrote:

> I had a bit hard time parsing the above, especially with "then",
> which probably would make it easier to read if it is not there.

Okay, I guess better to separate the explanation from the diagrams,
rather than weaving them together:

    For octopus merges where the first parent edge immediately merges into
    the next column to the left, the number of columns should be one less
    than the usual case.

    First parent to the left case:

    | *-.
    | |\ \
    |/ / /

    The usual case:

    | *-.
    | |\ \
    | | | *

> > Also refactor the code to iterate over columns rather than dashes,
> > building from an initial patch suggestion by Jeff King.
>
> s/suggestion/suggested/ perhaps?

Ok.

> It is unclear to me what "delta of columns" means here.  Is this
> because I am unfamiliar with the internal of graph.[ch] API (and
> 'delta of columns' is used elsewhere in the API internals already)?

No, I just meant difference in number of columns from the previous
line to the next. Actually, I had kind of wanted to use "new columns",
but that would be confusing with the num_new_columns variable actually
meaning the total number of columns in the next line.

> > +     int delta_cols = (graph->num_new_columns - graph->num_columns);
>
> So in the second picture above, new-columns (which is the columns
> used after showing the current line) is narrower (because 'x' reuses
> an already allocated column without getting a new one) than columns
> (which is the columns for the octopus merge we are showing)?
>
> I am not sure I follow what is going on around here, sorry.

Maybe it's clearer by saying "added columns" (also expanded the comments a bit)?

    /*
     * Usually, we add one new column for each parent (like the diagram
     * above) but sometimes the first parent goes into an existing column,
     * like this:
     *
     * | *---.
     * | |\ \ \
     * |/ / / /
     * x 0 1 2
     *
     * In which case the number of parents will be one greater than the
     * number of added columns.
     */
    int added_cols = (graph->num_new_columns - graph->num_columns);
    int parent_in_old_cols = graph->num_parents - added_cols;

--000000000000b518330577fd1a4f
Content-Type: text/x-diff; charset="US-ASCII"; 
	name="v7-0001-log-fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Disposition: attachment; 
	filename="v7-0001-log-fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jn59pz4o0>
X-Attachment-Id: f_jn59pz4o0

RnJvbSBhOWM5MDYwNWMwNjJiMzAyNzNkYWQzNWFkYmYzMTk5MDUwMjhjYWNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNl
Zm9yZ2UubmV0PgpEYXRlOiBTYXQsIDEgU2VwIDIwMTggMjA6MDc6MTYgLTA0MDAKU3ViamVjdDog
W1BBVENIIHY3XSBsb2c6IGZpeCBjb2xvcmluZyBvZiBjZXJ0YWluIG9jdHVwdXMgbWVyZ2Ugc2hh
cGVzCgpGb3Igb2N0b3B1cyBtZXJnZXMgd2hlcmUgdGhlIGZpcnN0IHBhcmVudCBlZGdlIGltbWVk
aWF0ZWx5IG1lcmdlcyBpbnRvCnRoZSBuZXh0IGNvbHVtbiB0byB0aGUgbGVmdCwgdGhlIG51bWJl
ciBvZiBjb2x1bW5zIHNob3VsZCBiZSBvbmUgbGVzcwp0aGFuIHRoZSB1c3VhbCBjYXNlLgoKRmly
c3QgcGFyZW50IHRvIHRoZSBsZWZ0IGNhc2U6Cgp8ICotLgp8IHxcIFwKfC8gLyAvCgpUaGUgdXN1
YWwgY2FzZToKCnwgKi0uCnwgfFwgXAp8IHwgfCAqCgpBbHNvIHJlZmFjdG9yIHRoZSBjb2RlIHRv
IGl0ZXJhdGUgb3ZlciBjb2x1bW5zIHJhdGhlciB0aGFuIGRhc2hlcywKYnVpbGRpbmcgZnJvbSBh
biBpbml0aWFsIHBhdGNoIHN1Z2dlc3RlZCBieSBKZWZmIEtpbmcuCgpTaWduZWQtb2ZmLWJ5OiBO
b2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNlZm9yZ2UubmV0PgpSZXZpZXdlZC1i
eTogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0PgotLS0KIGdyYXBoLmMgICAgICAgICAgICAgICAg
ICAgICAgfCAgNTggKysrKysrKysrKysrKysrKystLS0tLS0tCiB0L3Q0MjE0LWxvZy1ncmFwaC1v
Y3RvcHVzLnNoIHwgMTAyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIDIgZmlsZXMgY2hhbmdlZCwgMTQ1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNzU1IHQvdDQyMTQtbG9nLWdyYXBoLW9jdG9wdXMuc2gKCmRpZmYgLS1n
aXQgYS9ncmFwaC5jIGIvZ3JhcGguYwppbmRleCBlMWY2ZDNiZGRiLi5mNTMxMzU0ODVmIDEwMDY0
NAotLS0gYS9ncmFwaC5jCisrKyBiL2dyYXBoLmMKQEAgLTg0MiwyNyArODQyLDU1IEBAIHN0YXRp
YyB2b2lkIGdyYXBoX291dHB1dF9jb21taXRfY2hhcihzdHJ1Y3QgZ2l0X2dyYXBoICpncmFwaCwg
c3RydWN0IHN0cmJ1ZiAqc2IpCiB9CiAKIC8qCi0gKiBEcmF3IGFuIG9jdG9wdXMgbWVyZ2UgYW5k
IHJldHVybiB0aGUgbnVtYmVyIG9mIGNoYXJhY3RlcnMgd3JpdHRlbi4KKyAqIERyYXcgdGhlIGhv
cml6b250YWwgZGFzaGVzIG9mIGFuIG9jdG9wdXMgbWVyZ2UgYW5kIHJldHVybiB0aGUgbnVtYmVy
IG9mCisgKiBjaGFyYWN0ZXJzIHdyaXR0ZW4uCiAgKi8KIHN0YXRpYyBpbnQgZ3JhcGhfZHJhd19v
Y3RvcHVzX21lcmdlKHN0cnVjdCBnaXRfZ3JhcGggKmdyYXBoLAogCQkJCSAgICBzdHJ1Y3Qgc3Ry
YnVmICpzYikKIHsKIAkvKgotCSAqIEhlcmUgZGFzaGxlc3NfY29tbWl0cyByZXByZXNlbnRzIHRo
ZSBudW1iZXIgb2YgcGFyZW50cwotCSAqIHdoaWNoIGRvbid0IG5lZWQgdG8gaGF2ZSBkYXNoZXMg
KGJlY2F1c2UgdGhlaXIgZWRnZXMgZml0Ci0JICogbmVhdGx5IHVuZGVyIHRoZSBjb21taXQpLgot
CSAqLwotCWNvbnN0IGludCBkYXNobGVzc19jb21taXRzID0gMjsKLQlpbnQgY29sX251bSwgaTsK
LQlpbnQgbnVtX2Rhc2hlcyA9Ci0JCSgoZ3JhcGgtPm51bV9wYXJlbnRzIC0gZGFzaGxlc3NfY29t
bWl0cykgKiAyKSAtIDE7Ci0JZm9yIChpID0gMDsgaSA8IG51bV9kYXNoZXM7IGkrKykgewotCQlj
b2xfbnVtID0gKGkgLyAyKSArIGRhc2hsZXNzX2NvbW1pdHMgKyBncmFwaC0+Y29tbWl0X2luZGV4
OwotCQlzdHJidWZfd3JpdGVfY29sdW1uKHNiLCAmZ3JhcGgtPm5ld19jb2x1bW5zW2NvbF9udW1d
LCAnLScpOworCSAqIEhlcmUgZGFzaGxlc3NfcGFyZW50cyByZXByZXNlbnRzIHRoZSBudW1iZXIg
b2YgcGFyZW50cyB3aGljaCBkb24ndAorCSAqIG5lZWQgdG8gaGF2ZSBkYXNoZXMgKHRoZSBlZGdl
cyBsYWJlbGVkICIwIiBhbmQgIjEiKS4gIEFuZAorCSAqIGRhc2hmdWxfcGFyZW50cyBhcmUgdGhl
IHJlbWFpbmluZyBvbmVzLgorCSAqCisJICogfCAqLS0tLgorCSAqIHwgfFwgXCBcCisJICogfCB8
IHwgfCB8CisJICogeCAwIDEgMiAzCisJICoKKwkgKi8KKwljb25zdCBpbnQgZGFzaGxlc3NfcGFy
ZW50cyA9IDI7CisJaW50IGRhc2hmdWxfcGFyZW50cyA9IGdyYXBoLT5udW1fcGFyZW50cyAtIGRh
c2hsZXNzX3BhcmVudHM7CisKKwkvKgorCSAqIFVzdWFsbHksIHdlIGFkZCBvbmUgbmV3IGNvbHVt
biBmb3IgZWFjaCBwYXJlbnQgKGxpa2UgdGhlIGRpYWdyYW0KKwkgKiBhYm92ZSkgYnV0IHNvbWV0
aW1lcyB0aGUgZmlyc3QgcGFyZW50IGdvZXMgaW50byBhbiBleGlzdGluZyBjb2x1bW4sCisJICog
bGlrZSB0aGlzOgorCSAqCisJICogfCAqLS0tLgorCSAqIHwgfFwgXCBcCisJICogfC8gLyAvIC8K
KwkgKiB4IDAgMSAyCisJICoKKwkgKiBJbiB3aGljaCBjYXNlIHRoZSBudW1iZXIgb2YgcGFyZW50
cyB3aWxsIGJlIG9uZSBncmVhdGVyIHRoYW4gdGhlCisJICogbnVtYmVyIG9mIGFkZGVkIGNvbHVt
bnMuCisJICovCisJaW50IGFkZGVkX2NvbHMgPSAoZ3JhcGgtPm51bV9uZXdfY29sdW1ucyAtIGdy
YXBoLT5udW1fY29sdW1ucyk7CisJaW50IHBhcmVudF9pbl9vbGRfY29scyA9IGdyYXBoLT5udW1f
cGFyZW50cyAtIGFkZGVkX2NvbHM7CisKKwkvKgorCSAqIEluIGJvdGggY2FzZXMsIGNvbW1pdF9p
bmRleCBjb3JyZXNwb25kcyB0byB0aGUgZWRnZSBsYWJlbGVkICIwIi4KKwkgKi8KKwlpbnQgZmly
c3RfY29sID0gZ3JhcGgtPmNvbW1pdF9pbmRleCArIGRhc2hsZXNzX3BhcmVudHMKKwkgICAgLSBw
YXJlbnRfaW5fb2xkX2NvbHM7CisKKwlpbnQgaTsKKwlmb3IgKGkgPSAwOyBpIDwgZGFzaGZ1bF9w
YXJlbnRzOyBpKyspIHsKKwkJc3RyYnVmX3dyaXRlX2NvbHVtbihzYiwgJmdyYXBoLT5uZXdfY29s
dW1uc1tpK2ZpcnN0X2NvbF0sICctJyk7CisJCXN0cmJ1Zl93cml0ZV9jb2x1bW4oc2IsICZncmFw
aC0+bmV3X2NvbHVtbnNbaStmaXJzdF9jb2xdLAorCQkJCSAgICBpID09IGRhc2hmdWxfcGFyZW50
cy0xID8gJy4nIDogJy0nKTsKIAl9Ci0JY29sX251bSA9IChpIC8gMikgKyBkYXNobGVzc19jb21t
aXRzICsgZ3JhcGgtPmNvbW1pdF9pbmRleDsKLQlzdHJidWZfd3JpdGVfY29sdW1uKHNiLCAmZ3Jh
cGgtPm5ld19jb2x1bW5zW2NvbF9udW1dLCAnLicpOwotCXJldHVybiBudW1fZGFzaGVzICsgMTsK
KwlyZXR1cm4gMiAqIGRhc2hmdWxfcGFyZW50czsKIH0KIAogc3RhdGljIHZvaWQgZ3JhcGhfb3V0
cHV0X2NvbW1pdF9saW5lKHN0cnVjdCBnaXRfZ3JhcGggKmdyYXBoLCBzdHJ1Y3Qgc3RyYnVmICpz
YikKZGlmZiAtLWdpdCBhL3QvdDQyMTQtbG9nLWdyYXBoLW9jdG9wdXMuc2ggYi90L3Q0MjE0LWxv
Zy1ncmFwaC1vY3RvcHVzLnNoCm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAu
LmRhYjk2Yzg5YWEKLS0tIC9kZXYvbnVsbAorKysgYi90L3Q0MjE0LWxvZy1ncmFwaC1vY3RvcHVz
LnNoCkBAIC0wLDAgKzEsMTAyIEBACisjIS9iaW4vc2gKKwordGVzdF9kZXNjcmlwdGlvbj0nZ2l0
IGxvZyAtLWdyYXBoIG9mIHNrZXdlZCBsZWZ0IG9jdG9wdXMgbWVyZ2UuJworCisuIC4vdGVzdC1s
aWIuc2gKKwordGVzdF9leHBlY3Rfc3VjY2VzcyAnc2V0IHVwIG1lcmdlIGhpc3RvcnknICcKKwlj
YXQgPmV4cGVjdC51bmNvbG9yZWQgPDwtXEVPRiAmJgorCSogbGVmdAorCXwgKi0tLS4gICBvY3Rv
cHVzLW1lcmdlCisJfCB8XCBcIFwKKwl8LyAvIC8gLworCXwgfCB8ICogNAorCXwgfCAqIHwgMwor
CXwgfCB8LworCXwgKiB8IDIKKwl8IHwvCisJKiB8IDEKKwl8LworCSogaW5pdGlhbAorCUVPRgor
CWNhdCA+ZXhwZWN0LmNvbG9ycyA8PC1cRU9GICYmCisJKiBsZWZ0CisJPFJFRD58PFJFU0VUPiAq
PEJMVUU+LTxSRVNFVD48QkxVRT4tPFJFU0VUPjxNQUdFTlRBPi08UkVTRVQ+PE1BR0VOVEE+LjxS
RVNFVD4gICBvY3RvcHVzLW1lcmdlCisJPFJFRD58PFJFU0VUPiA8UkVEPnw8UkVTRVQ+PFlFTExP
Vz5cPFJFU0VUPiA8QkxVRT5cPFJFU0VUPiA8TUFHRU5UQT5cPFJFU0VUPgorCTxSRUQ+fDxSRVNF
VD48UkVEPi88UkVTRVQ+IDxZRUxMT1c+LzxSRVNFVD4gPEJMVUU+LzxSRVNFVD4gPE1BR0VOVEE+
LzxSRVNFVD4KKwk8UkVEPnw8UkVTRVQ+IDxZRUxMT1c+fDxSRVNFVD4gPEJMVUU+fDxSRVNFVD4g
KiA0CisJPFJFRD58PFJFU0VUPiA8WUVMTE9XPnw8UkVTRVQ+ICogPE1BR0VOVEE+fDxSRVNFVD4g
MworCTxSRUQ+fDxSRVNFVD4gPFlFTExPVz58PFJFU0VUPiA8TUFHRU5UQT58PFJFU0VUPjxNQUdF
TlRBPi88UkVTRVQ+CisJPFJFRD58PFJFU0VUPiAqIDxNQUdFTlRBPnw8UkVTRVQ+IDIKKwk8UkVE
Pnw8UkVTRVQ+IDxNQUdFTlRBPnw8UkVTRVQ+PE1BR0VOVEE+LzxSRVNFVD4KKwkqIDxNQUdFTlRB
Pnw8UkVTRVQ+IDEKKwk8TUFHRU5UQT58PFJFU0VUPjxNQUdFTlRBPi88UkVTRVQ+CisJKiBpbml0
aWFsCisJRU9GCisJdGVzdF9jb21taXQgaW5pdGlhbCAmJgorCWZvciBpIGluIDEgMiAzIDQgOyBk
bworCQlnaXQgY2hlY2tvdXQgbWFzdGVyIC1iICRpIHx8IHJldHVybiAkPworCQkjIE1ha2UgdGFn
IG5hbWUgZGlmZmVyZW50IGZyb20gYnJhbmNoIG5hbWUsIHRvIGF2b2lkCisJCSMgYW1iaWd1aXR5
IGVycm9yIHdoZW4gY2FsbGluZyBjaGVja291dC4KKwkJdGVzdF9jb21taXQgJGkgJGkgJGkgdGFn
JGkgfHwgcmV0dXJuICQ/CisJZG9uZSAmJgorCWdpdCBjaGVja291dCAxIC1iIG1lcmdlICYmCisJ
dGVzdF90aWNrICYmCisJZ2l0IG1lcmdlIC1tIG9jdG9wdXMtbWVyZ2UgMSAyIDMgNCAmJgorCWdp
dCBjaGVja291dCAxIC1iIEwgJiYKKwl0ZXN0X2NvbW1pdCBsZWZ0CisnCisKK3Rlc3RfZXhwZWN0
X3N1Y2Nlc3MgJ2xvZyAtLWdyYXBoIHdpdGggdHJpY2t5IG9jdG9wdXMgbWVyZ2Ugd2l0aCBjb2xv
cnMnICcKKwl0ZXN0X2NvbmZpZyBsb2cuZ3JhcGhDb2xvcnMgcmVkLGdyZWVuLHllbGxvdyxibHVl
LG1hZ2VudGEsY3lhbiAmJgorCWdpdCBsb2cgLS1jb2xvcj1hbHdheXMgLS1ncmFwaCAtLWRhdGUt
b3JkZXIgLS1wcmV0dHk9dGZvcm1hdDolcyAtLWFsbCA+YWN0dWFsLmNvbG9ycy5yYXcgJiYKKwl0
ZXN0X2RlY29kZV9jb2xvciA8YWN0dWFsLmNvbG9ycy5yYXcgfCBzZWQgInMvICpcJC8vIiA+YWN0
dWFsLmNvbG9ycyAmJgorCXRlc3RfY21wIGV4cGVjdC5jb2xvcnMgYWN0dWFsLmNvbG9ycworJwor
Cit0ZXN0X2V4cGVjdF9zdWNjZXNzICdsb2cgLS1ncmFwaCB3aXRoIHRyaWNreSBvY3RvcHVzIG1l
cmdlLCBubyBjb2xvcicgJworCWdpdCBsb2cgLS1jb2xvcj1uZXZlciAtLWdyYXBoIC0tZGF0ZS1v
cmRlciAtLXByZXR0eT10Zm9ybWF0OiVzIC0tYWxsID5hY3R1YWwucmF3ICYmCisJc2VkICJzLyAq
XCQvLyIgYWN0dWFsLnJhdyA+YWN0dWFsICYmCisJdGVzdF9jbXAgZXhwZWN0LnVuY29sb3JlZCBh
Y3R1YWwKKycKKworIyBSZXBlYXQgdGhlIHByZXZpb3VzIHR3byB0ZXN0cyB3aXRoICJub3JtYWwi
IG9jdG9wdXMgbWVyZ2UgKGkuZS4sCisjIHdpdGhvdXQgdGhlIGZpcnN0IHBhcmVudCBza2V3aW5n
IHRvIHRoZSAibGVmdCIgYnJhbmNoIGNvbHVtbikuCisKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2xv
ZyAtLWdyYXBoIHdpdGggbm9ybWFsIG9jdG9wdXMgbWVyZ2UsIG5vIGNvbG9yJyAnCisJY2F0ID5l
eHBlY3QudW5jb2xvcmVkIDw8LVxFT0YgJiYKKwkqLS0tLiAgIG9jdG9wdXMtbWVyZ2UKKwl8XCBc
IFwKKwl8IHwgfCAqIDQKKwl8IHwgKiB8IDMKKwl8IHwgfC8KKwl8ICogfCAyCisJfCB8LworCSog
fCAxCisJfC8KKwkqIGluaXRpYWwKKwlFT0YKKwlnaXQgbG9nIC0tY29sb3I9bmV2ZXIgLS1ncmFw
aCAtLWRhdGUtb3JkZXIgLS1wcmV0dHk9dGZvcm1hdDolcyBtZXJnZSA+YWN0dWFsLnJhdyAmJgor
CXNlZCAicy8gKlwkLy8iIGFjdHVhbC5yYXcgPmFjdHVhbCAmJgorCXRlc3RfY21wIGV4cGVjdC51
bmNvbG9yZWQgYWN0dWFsCisnCisKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2xvZyAtLWdyYXBoIHdp
dGggbm9ybWFsIG9jdG9wdXMgbWVyZ2Ugd2l0aCBjb2xvcnMnICcKKwljYXQgPmV4cGVjdC5jb2xv
cnMgPDwtXEVPRiAmJgorCSo8WUVMTE9XPi08UkVTRVQ+PFlFTExPVz4tPFJFU0VUPjxCTFVFPi08
UkVTRVQ+PEJMVUU+LjxSRVNFVD4gICBvY3RvcHVzLW1lcmdlCisJPFJFRD58PFJFU0VUPjxHUkVF
Tj5cPFJFU0VUPiA8WUVMTE9XPlw8UkVTRVQ+IDxCTFVFPlw8UkVTRVQ+CisJPFJFRD58PFJFU0VU
PiA8R1JFRU4+fDxSRVNFVD4gPFlFTExPVz58PFJFU0VUPiAqIDQKKwk8UkVEPnw8UkVTRVQ+IDxH
UkVFTj58PFJFU0VUPiAqIDxCTFVFPnw8UkVTRVQ+IDMKKwk8UkVEPnw8UkVTRVQ+IDxHUkVFTj58
PFJFU0VUPiA8QkxVRT58PFJFU0VUPjxCTFVFPi88UkVTRVQ+CisJPFJFRD58PFJFU0VUPiAqIDxC
TFVFPnw8UkVTRVQ+IDIKKwk8UkVEPnw8UkVTRVQ+IDxCTFVFPnw8UkVTRVQ+PEJMVUU+LzxSRVNF
VD4KKwkqIDxCTFVFPnw8UkVTRVQ+IDEKKwk8QkxVRT58PFJFU0VUPjxCTFVFPi88UkVTRVQ+CisJ
KiBpbml0aWFsCisJRU9GCisJdGVzdF9jb25maWcgbG9nLmdyYXBoQ29sb3JzIHJlZCxncmVlbix5
ZWxsb3csYmx1ZSxtYWdlbnRhLGN5YW4gJiYKKwlnaXQgbG9nIC0tY29sb3I9YWx3YXlzIC0tZ3Jh
cGggLS1kYXRlLW9yZGVyIC0tcHJldHR5PXRmb3JtYXQ6JXMgbWVyZ2UgPmFjdHVhbC5jb2xvcnMu
cmF3ICYmCisJdGVzdF9kZWNvZGVfY29sb3IgPGFjdHVhbC5jb2xvcnMucmF3IHwgc2VkICJzLyAq
XCQvLyIgPmFjdHVhbC5jb2xvcnMgJiYKKwl0ZXN0X2NtcCBleHBlY3QuY29sb3JzIGFjdHVhbC5j
b2xvcnMKKycKK3Rlc3RfZG9uZQotLSAKMi4xMS4wCgo=
--000000000000b518330577fd1a4f--
